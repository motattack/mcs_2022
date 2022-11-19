-- У магазина электротехники есть интернет магазин.
-- В нём есть учетные записи - администрации и покупателей.
-- У учетной записи есть профиль с изображением, e-mail, пароль, имя, активность, роль.
-- Есть роли, у которых есть название, описание, и права.
-- Есть товары у которых есть - категория, название, артикл (может и не быть), цена, старая цена, описание (может и не быть), количество, производитель.
-- У производителя может быть много товаров.
-- У категорий есть название, человекочитаемое имя, картинка, левый потомок, правый потомок, номер, уровень и родитель..
-- Есть заказы, с указанием статуса (в корзине, ожидает оплаты, оплачен), общей ценой, датой создания, коментарием и id пользователя
-- Есть товары в заказе, есть количество, цена, id товара, id заказа
-- Есть платежи у которых есть, сумма, время, коментарий и пользователь.

CREATE TABLE "auth_users"
(
    "id"        INTEGER      NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email"     VARCHAR(255) NOT NULL UNIQUE,
    "password"  VARCHAR(128) NOT NULL,
    "name"      VARCHAR(255),
    "is_active" BOOL         NOT NULL DEFAULT 1,
    "role_id"   INTEGER      NOT NULL,
    FOREIGN KEY ("role_id") REFERENCES "auth_roles" ("id")
);

CREATE TABLE "auth_roles"
(
    "id"   INTEGER      NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" VARCHAR(255) NOT NULL,
    "desc" VARCHAR(255),
    "perm" VARCHAR(255)
);

CREATE TABLE "auth_profiles"
(
    "id"      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "image"   VARCHAR(255) DEFAULT 'default.apng',
    "user_id" INTEGER NOT NULL UNIQUE,
    FOREIGN KEY ("user_id") REFERENCES "auth_users" ("id")
);

CREATE TABLE "categories"
(
    "id"        INTEGER      NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name"      VARCHAR(255) NOT NULL,
    "slug"      VARCHAR(255) NOT NULL UNIQUE,
    "image"     VARCHAR(255) DEFAULT 'cat_default.svg',
    "lft"       INTEGER      NOT NULL,
    "rgt"       INTEGER      NOT NULL,
    "tree_id"   INTEGER      NOT NULL,
    "level"     INTEGER      NOT NULL,
    "parent_id" INTEGER      DEFAULT NULL,
    FOREIGN KEY ("parent_id") REFERENCES "categories" ("id")
);

CREATE TABLE "manufacturers"
(
    "id"   INTEGER      NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" VARCHAR(255) NOT NULL
);

DROP TABLE "items";

CREATE TABLE "items"
(
    "id"              INTEGER      NOT NULL PRIMARY KEY AUTOINCREMENT,
    "category_id"     INTEGER      NOT NULL,
    "name"            VARCHAR(255) NOT NULL,
    "article"         VARCHAR(255),
    "price"           DECIMAL,
    "old_price"       DECIMAL,
    "description"     TEXT,
    "count"           INTEGER      NOT NULL,
    "manufacturer_id" INTEGER,
    FOREIGN KEY ("category_id") REFERENCES "categories" ("id"),
    FOREIGN KEY ("manufacturer_id") REFERENCES "manufacturers" ("id")
);

CREATE TABLE "payments"
(
    "id"      INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    "amount"  DECIMAL,
    "time"    DATETIME NOT NULL,
    "comment" VARCHAR(255),
    "user_id" INTEGER  NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "auth_users" ("id")
);

CREATE TABLE "orders"
(
    "id"            INTEGER     NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status"        VARCHAR(32) NOT NULL CHECK (status IN ('cart', 'waiting_for_payment', 'paid')),
    "amount"        DECIMAL,
    "creation_time" DATETIME    NOT NULL,
    "comment"       TEXT,
    "payment_id"    INTEGER,
    "user_id"       INTEGER     NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "auth_users" ("id"),
    FOREIGN KEY ("payment_id") REFERENCES "payments" ("id")
);

CREATE TABLE "order_items"
(
    "id"       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "quantity" INTEGER NOT NULL CHECK ("quantity" >= 0),
    "price"    DECIMAL,
    "item_id"  INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,

    FOREIGN KEY ("order_id") REFERENCES "orders" ("id"),
    FOREIGN KEY ("item_id") REFERENCES "items" ("id")
);
