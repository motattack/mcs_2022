CREATE TABLE "contacts" (
	id INTEGER PRIMARY KEY,
	name TEXT
);

CREATE TABLE "email" (
	address TEXT,
	contact_id INTEGER,
	FOREIGN KEY (contact_id)  REFERENCES contacts (id)
);

CREATE TABLE "phones" (
	number TEXT,
	contact_id INTEGER,
	FOREIGN KEY (contact_id)  REFERENCES contacts (id)
);
