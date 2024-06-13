-- Database Name: fit_track
-- USER is a reserved keyword with Postgres
-- You must use double quotes in every query that user is in:
-- ex. SELECT * FROM "user";
-- Otherwise you will have errors!
CREATE TABLE IF NOT EXISTS "user" (
	"id" serial primary key,
	 "username" varChar(80) not null UNIQUE,
	"password" varChar(100) not null,
	"admin" boolean default false
);

CREATE TABLE IF NOT EXISTS "user_info" (
	"id" serial primary key,
	"user_id" int references "user" not null unique,
	"height" int not null,
	"weight" int not null, 
	"age" int not null,
	"gender" varchar(10) not null,
	CHECK("gender" IN ('Male', 'Female')),
	"bmr" int not null
	
);

CREATE TABLE IF NOT EXISTS "musclegroups" (
	"id" serial primary key,
	"name" varchar(100) not null unique
);

CREATE TABLE IF NOT EXISTS "workout_log"(
	"id" serial primary key,
	"user_id" int references "user" not null,
	"date" DATE not null
);

CREATE TABLE IF NOT EXISTS  "exercises"(
	"id" serial primary key,
	"name" varchar(100) not null unique,
	"musclegroup_id" int references "musclegroups" not null,
	"description" varchar(2500) not null,
	"image_url" varchar(1000),
	"video_url" varchar(1000)
);

CREATE TABLE IF NOT EXISTS "workout_details"(
	"id" serial primary key,
	"workout_id" int references "workout_log" not null,
	"exercise_id" int references "exercises" not null,
	"sets" int not null,
	"reps" int not null,
	"weight" int not null
	
);

CREATE TABLE IF NOT EXISTS "calorie_tracker"(
	"id" serial primary key,
	"users_id" int references "user" not null,
	"date" DATE not null,
	"food_name" varchar(100) not null,
	"serving_size" int ,
	"calories" int not null,
	"protein" int,
	"carbs" int,
	"fats" int
);