CREATE TABLE "movie" (
    "id" SERIAL PRIMARY KEY,
    "title" VARCHAR(255) NOT NULL
);

INSERT INTO "movie" ("title")
VALUES ('Captain America'),
        ('Birdman');
