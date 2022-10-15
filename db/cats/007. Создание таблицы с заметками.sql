CREATE TABLE Notes(
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Note TEXT UNIQUE NOT NULL,
    TimeOfCreation DATETIME NOT NULL,
    ProgressMade REAL CHECK(ProgressMade BETWEEN 0 AND 1) DEFAULT 0,
    Status TEXT CHECK(Status IN('started', 'accepted', 'canceled')) DEFAULT 'started'
);
