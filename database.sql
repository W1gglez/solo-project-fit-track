CREATE TABLE IF NOT EXISTS "user" (
	"id" serial primary key,
	 "username" varChar(80) not null UNIQUE,
	"password" varChar(100) not null,
	"admin" boolean default false
);

CREATE TABLE IF NOT EXISTS "user_info" (
	"id" serial PRIMARY KEY,
    "user_id" int UNIQUE,
    "height" int NOT NULL,
    "weight" int NOT NULL,
    "age" int NOT NULL,
    "gender" varchar(10) NOT NULL,
    CHECK("gender" IN ('Male', 'Female')),
    "bmr" int NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE
	
);

CREATE TABLE IF NOT EXISTS "musclegroups" (
	"id" serial primary key,
	"name" varchar(100) not null unique
);

CREATE TABLE IF NOT EXISTS "exercise_muscles" (
    "exercise_id" INT REFERENCES "exercises",
    "muscle_id" INT REFERENCES "musclegroups",
    PRIMARY KEY ("exercise_id", "muscle_id")
);

CREATE TABLE IF NOT EXISTS  "exercises"(
	"id" serial primary key,
	"name" varchar(100) not null unique,
	"steps" varchar(2500) not null,
	"image_url" varchar(1000),
	"video_url" varchar(1000)
);

CREATE TABLE IF NOT EXISTS "workout_log"(
	"id" serial primary key,
	"user_id" int references "user" ON DELETE CASCADE,
	"date" DATE not null
);

CREATE TABLE IF NOT EXISTS "workout_details"(
	"id" serial primary key,
	"workout_id" int references "workout_log" ON DELETE CASCADE,
	"exercise_id" int references "exercises" 
);

CREATE TABLE IF NOT EXISTS "set_info" (
    "id" SERIAL PRIMARY KEY,
    "detail_id" INT REFERENCES "workout_details" ON DELETE CASCADE,
    "set_number" INT NOT NULL,
    "reps" INT NOT NULL,
    "weight" DECIMAL NOT NULL
);


CREATE TABLE IF NOT EXISTS "calorie_log"(
	"id" serial primary key,
	"user_id" int references "user" ON DELETE CASCADE,
	"date" DATE not null
);

CREATE TABLE IF NOT EXISTS "cl_entry"(
	"entry_id" serial primary key,
	"log_id" int references "calorie_log" ON DELETE CASCADE,
	"food_name" varchar(100) not null,
	"serving_size" varchar(25),
	"calories" int not null,
	"protein" int,
	"carbs" int,
	"fats" int
);
