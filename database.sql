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
	--"musclegroup_id" int references "musclegroups" not null,
	"steps" varchar(2500) not null,
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

CREATE TABLE IF NOT EXISTS "exercise_muscles" (
    "exercise_id" INT,
    "muscle_id" INT,
    PRIMARY KEY ("exercise_id", "muscle_id"),
    FOREIGN KEY ("exercise_id") REFERENCES "exercises",
    FOREIGN KEY ("muscle_id") REFERENCES "musclegroups"
);


INSERT INTO musclegroups ("name")
VALUES 
    ('Chest'),
    ('Back'),
    ('Shoulders'),
    ('Biceps'),
    ('Triceps'),
    ('Quadriceps'),
    ('Hamstrings'),
    ('Calves'),
    ('Glutes'),
    ('Abs'),
    ('Forearms');

INSERT INTO exercises ("name", steps, image_url) VALUES
('Bench Press', '1. Lie on a flat bench. 2. Grip the bar slightly wider than shoulder-width. 3. Lower the bar to your chest. 4. Press the bar back up to the starting position.', 'http://example.com/bench_press.jpg'),
('Deadlift', '1. Stand with feet hip-width apart, barbell over mid-foot. 2. Bend at the hips and grip the bar. 3. Lift the bar by straightening your back and hips. 4. Lower the bar back to the starting position.', 'http://example.com/deadlift.jpg'),
('Squat', '1. Stand with feet shoulder-width apart, barbell on your shoulders. 2. Lower your body until thighs are parallel to the ground. 3. Return to the starting position.', 'http://example.com/squat.jpg'),
('Overhead Squat', '1. Stand with feet shoulder-width apart, holding a barbell overhead. 2. Lower your body into a squat position while keeping the barbell overhead. 3. Return to the starting position.', 'http://example.com/overhead_squat.jpg'),
('Single-Leg Deadlift', '1. Stand on one leg with a slight bend in the knee, holding a dumbbell in each hand. 2. Bend at the hips and lower the dumbbells towards the floor. 3. Return to the starting position.', 'http://example.com/single_leg_deadlift.jpg');


INSERT INTO exercise_muscles (exercise_id, muscle_id) VALUES
(1, 1), -- Bench Press - Chest
(1, 5), -- Bench Press - Triceps
(2, 2), -- Deadlift - Back
(2, 6), -- Deadlift - Quads
(2, 7), -- Deadlift - Hamstrings
(2, 9), -- Deadlift - Glutes
(3, 6), -- Squat - Quads
(3, 7), -- Squat - Hamstrings
(3, 9), -- Squat - Glutes
(4, 3), -- Overhead Squat - Shoulders
(4, 6), -- Overhead Squat - Quads
(4, 7), -- Overhead Squat - Hamstrings
(4, 9), -- Overhead Squat - Glutes
(5, 6), -- Single-Leg Deadlift - Quads
(5, 7), -- Single-Leg Deadlift - Hamstrings
(5, 9) -- Single-Leg Deadlift - Glutes
;

INSERT INTO exercises ( "name", steps, image_url) VALUES
('Sumo Deadlift', '1. Stand with feet wider than shoulder-width apart and toes pointed out. 2. Grip the barbell with hands inside your knees. 3. Lift the barbell by extending your hips and knees. 4. Lower the barbell back to the floor.', 'http://example.com/sumo_deadlift.jpg'),
( 'Cable Tricep Pushdown', '1. Stand facing a cable machine with the handle attached to the high pulley. 2. Grip the handle with an overhand grip. 3. Push the handle down until your arms are fully extended. 4. Return to the starting position.', 'http://example.com/cable_tricep_pushdown.jpg'),
( 'Tricep Kickback', '1. Bend at your hips and knees, holding a dumbbell in each hand. 2. Extend your arms behind you while keeping your upper arms stationary. 3. Return to the starting position.', 'http://example.com/tricep_kickback.jpg'),
( 'Kettlebell Swing', '1. Stand with feet shoulder-width apart, holding a kettlebell with both hands. 2. Swing the kettlebell between your legs and then up to shoulder height. 3. Return to the starting position.', 'http://example.com/kettlebell_swing.jpg'),
( 'Good Morning', '1. Stand with feet shoulder-width apart, holding a barbell across your shoulders. 2. Bend at your hips while keeping your back straight. 3. Return to the starting position.', 'http://example.com/good_morning.jpg'),
( 'Standing Military Press', '1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell overhead until your arms are fully extended. 3. Lower the barbell back to the starting position.', 'http://example.com/standing_military_press.jpg'),
( 'Zottman Curl', '1. Stand with a dumbbell in each hand, palms facing up. 2. Curl the weights to shoulder height. 3. Rotate your palms to face down and lower the weights. 4. Rotate your palms back to the starting position.', 'http://example.com/zottman_curl.jpg'),
( 'Spider Curl', '1. Lie face down on an incline bench, holding a dumbbell in each hand. 2. Curl the weights towards your shoulders. 3. Lower back to the starting position.', 'http://example.com/spider_curl.jpg'),
( 'Barbell Row', '1. Stand with feet shoulder-width apart, holding a barbell with an overhand grip. 2. Bend at the hips and knees, lowering the barbell to mid-shin height. 3. Pull the barbell towards your torso. 4. Lower back to the starting position.', 'http://example.com/barbell_row.jpg'),
( 'T-Bar Row', '1. Stand over a T-bar row machine, gripping the handles. 2. Bend at the hips and knees, lowering your torso. 3. Pull the handles towards your torso. 4. Lower back to the starting position.', 'http://example.com/t_bar_row.jpg'),
( 'Face Pull', '1. Attach a rope to a high pulley. 2. Pull the rope towards your face while flaring your elbows out. 3. Slowly return to the starting position.', 'http://example.com/face_pull.jpg'),
( 'Inverted Row', '1. Lie underneath a bar set at hip height. 2. Grip the bar with an overhand grip. 3. Pull your chest up to the bar. 4. Lower back to the starting position.', 'http://example.com/inverted_row.jpg'),
( 'Single-Arm Dumbbell Row', '1. Place one knee and hand on a bench, holding a dumbbell in the other hand. 2. Pull the dumbbell towards your torso. 3. Lower back to the starting position.', 'http://example.com/single_arm_dumbbell_row.jpg'),
( 'Renegade Row', '1. Get into a plank position with a dumbbell in each hand. 2. Row one dumbbell towards your torso while balancing on the other arm. 3. Return to the starting position and repeat with the other arm.', 'http://example.com/renegade_row.jpg'),
( 'Cable Upright Row', '1. Stand facing a cable machine with the handle attached to the low pulley. 2. Grip the handle with an overhand grip. 3. Pull the handle up to chest height. 4. Lower back to the starting position.', 'http://example.com/cable_upright_row.jpg'),
( 'Standing Overhead Press', '1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell overhead until your arms are fully extended. 3. Lower the barbell back to the starting position.', 'http://example.com/standing_overhead_press.jpg'),
( 'Seated Dumbbell Press', '1. Sit on a bench with back support, holding a dumbbell in each hand at shoulder height. 2. Press the weights up until your arms are fully extended. 3. Lower the weights back to the starting position.', 'http://example.com/seated_dumbbell_press.jpg'),
( 'Chest-Supported Row', '1. Lie face down on an incline bench, holding a dumbbell in each hand. 2. Pull the weights towards your torso. 3. Lower back to the starting position.', 'http://example.com/chest_supported_row.jpg'),
( 'Trap Bar Deadlift', '1. Stand inside a trap bar with feet hip-width apart. 2. Grip the handles and lift the bar by extending your hips and knees. 3. Lower the bar back to the floor.', 'http://example.com/trap_bar_deadlift.jpg'),
( 'Pallof Press', '1. Stand perpendicular to a cable machine, holding the handle at chest height. 2. Press the handle out in front of you. 3. Return to the starting position.', 'http://example.com/pallof_press.jpg'),
( 'Cable Lateral Raise', '1. Stand next to a cable machine with the handle attached to the low pulley. 2. Hold the handle with the arm furthest from the machine. 3. Raise your arm out to the side until it is parallel to the floor. 4. Lower back to the starting position.', 'http://example.com/cable_lateral_raise.jpg'),
( 'Smith Machine Shoulder Press', '1. Sit on a bench with back support under a smith machine. 2. Grip the bar with hands slightly wider than shoulder-width apart. 3. Press the bar up until your arms are fully extended. 4. Lower back to the starting position.', 'http://example.com/smith_machine_shoulder_press.jpg'),
( 'Smith Machine Row', '1. Stand with feet shoulder-width apart under a smith machine bar. 2. Grip the bar with an overhand grip and pull it towards your torso. 3. Lower back to the starting position.', 'http://example.com/smith_machine_row.jpg'),
( 'Smith Machine Deadlift', '1. Stand with feet shoulder-width apart under a smith machine bar. 2. Grip the bar with an overhand grip and lift it by extending your hips and knees. 3. Lower back to the starting position.', 'http://example.com/smith_machine_deadlift.jpg'),
( 'Smith Machine Calf Raise', '1. Stand with feet shoulder-width apart under a smith machine bar. 2. Raise your heels to stand on your tiptoes. 3. Lower back to the starting position.', 'http://example.com/smith_machine_calf_raise.jpg'),
( 'Landmine Squat', '1. Stand with feet shoulder-width apart, holding a landmine barbell at chest height. 2. Lower your body into a squat position. 3. Return to the starting position.', 'http://example.com/landmine_squat.jpg'),
( 'Landmine Press', '1. Stand with feet shoulder-width apart, holding a landmine barbell with one hand at shoulder height. 2. Press the barbell overhead. 3. Lower back to the starting position.', 'http://example.com/landmine_press.jpg');

INSERT INTO exercise_muscles (exercise_id, muscle_id) VALUES
(6, 2),  -- Sumo Deadlift - Back
(6, 6),  -- Sumo Deadlift - Quads
(6, 7),  -- Sumo Deadlift - Hamstrings
(6, 9),  -- Sumo Deadlift - Glutes
(7, 5),  -- Cable Tricep Pushdown - Triceps
(8, 5),  -- Tricep Kickback - Triceps
(9, 6),  -- Kettlebell Swing - Quads
(9, 7),  -- Kettlebell Swing - Hamstrings
(9, 9),  -- Kettlebell Swing - Glutes
(10, 2), -- Good Morning - Back
(10, 7), -- Good Morning - Hamstrings
(10, 9), -- Good Morning - Glutes
(11, 3), -- Standing Military Press - Shoulders
(11, 5), -- Standing Military Press - Triceps
(12, 4), -- Zottman Curl - Biceps
(12, 5), -- Zottman Curl - Triceps
(13, 4), -- Spider Curl - Biceps
(14, 2), -- Barbell Row - Back
(14, 4), -- Barbell Row - Biceps
(15, 2), -- T-Bar Row - Back
(15, 4), -- T-Bar Row - Biceps
(16, 3), -- Face Pull - Shoulders
(16, 4), -- Face Pull - Biceps
(17, 2), -- Inverted Row - Back
(17, 4), -- Inverted Row - Biceps
(18, 2), -- Single-Arm Dumbbell Row - Back
(18, 4), -- Single-Arm Dumbbell Row - Biceps
(19, 2), -- Renegade Row - Back
(19, 4), -- Renegade Row - Biceps
(19, 10), -- Renegade Row - Abs
(20, 3), -- Cable Upright Row - Shoulders
(20, 4), -- Cable Upright Row - Biceps
(21, 3), -- Standing Overhead Press - Shoulders
(21, 5), -- Standing Overhead Press - Triceps
(22, 3), -- Seated Dumbbell Press - Shoulders
(22, 5), -- Seated Dumbbell Press - Triceps
(23, 2), -- Chest-Supported Row - Back
(23, 4), -- Chest-Supported Row - Biceps
(24, 6), -- Trap Bar Deadlift - Quads
(24, 7), -- Trap Bar Deadlift - Hamstrings
(24, 9), -- Trap Bar Deadlift - Glutes
(25, 10), -- Pallof Press - Abs
(26, 3), -- Cable Lateral Raise - Shoulders
(27, 3), -- Smith Machine Shoulder Press - Shoulders
(27, 5), -- Smith Machine Shoulder Press - Triceps
(28, 2), -- Smith Machine Row - Back
(28, 4), -- Smith Machine Row - Biceps
(29, 2), -- Smith Machine Deadlift - Back
(29, 6), -- Smith Machine Deadlift - Quads
(29, 7), -- Smith Machine Deadlift - Hamstrings
(29, 9), -- Smith Machine Deadlift - Glutes
(30, 8), -- Smith Machine Calf Raise - Calves
(31, 6), -- Landmine Squat - Quads
(31, 7), -- Landmine Squat - Hamstrings
(31, 9), -- Landmine Squat - Glutes
(32, 3), -- Landmine Press - Shoulders
(32, 5); -- Landmine Press - Triceps

INSERT INTO exercises ("name", steps, image_url) VALUES
('Reverse Fly', '1. Stand with feet hip-width apart, holding dumbbells. 2. Bend at the hips, keeping your back straight. 3. Raise your arms out to the sides. 4. Lower back to the starting position.', 'http://example.com/reverse_fly.jpg'),
( 'Lat Pulldown', '1. Sit at a lat pulldown machine, grip the bar wider than shoulder-width. 2. Pull the bar down to your chest. 3. Return to the starting position.', 'http://example.com/lat_pulldown.jpg'),
( 'Preacher Curl', '1. Sit at a preacher bench, holding an EZ curl bar. 2. Curl the bar towards your shoulders. 3. Lower back to the starting position.', 'http://example.com/preacher_curl.jpg'),
( 'Leg Press', '1. Sit on a leg press machine, feet shoulder-width apart on the platform. 2. Push the platform away until your legs are extended. 3. Return to the starting position.', 'http://example.com/leg_press.jpg'),
( 'Leg Extension', '1. Sit on a leg extension machine, adjust the pad above your ankles. 2. Extend your legs until they are straight. 3. Return to the starting position.', 'http://example.com/leg_extension.jpg'),
( 'Leg Curl', '1. Lie face down on a leg curl machine. 2. Curl your legs up towards your glutes. 3. Return to the starting position.', 'http://example.com/leg_curl.jpg'),
( 'Hip Thrust', '1. Sit on the floor with your upper back resting on a bench. 2. Place a barbell over your hips. 3. Thrust your hips up until your body is in a straight line. 4. Return to the starting position.', 'http://example.com/hip_thrust.jpg'),
( 'Glute Bridge', '1. Lie on your back with knees bent and feet flat on the floor. 2. Lift your hips until your body is in a straight line. 3. Return to the starting position.', 'http://example.com/glute_bridge.jpg'),
( 'Step-Up', '1. Stand in front of a bench or step, holding dumbbells. 2. Step up with one foot, then the other. 3. Step back down to the starting position.', 'http://example.com/step_up.jpg'),
( 'Bulgarian Split Squat', '1. Stand a few feet in front of a bench. 2. Place one foot on the bench behind you. 3. Lower your body until your front thigh is parallel to the floor. 4. Return to the starting position.', 'http://example.com/bulgarian_split_squat.jpg'),
( 'Single-Leg Squat', '1. Stand on one leg with the other extended in front of you. 2. Lower your body into a squat. 3. Return to the starting position.', 'http://example.com/single_leg_squat.jpg'),
( 'Calf Raise', '1. Stand with feet hip-width apart, holding dumbbells. 2. Raise your heels to stand on your tiptoes. 3. Lower back to the starting position.', 'http://example.com/calf_raise.jpg'),
( 'Seated Calf Raise', '1. Sit on a calf raise machine. 2. Place the balls of your feet on the footplate. 3. Raise your heels. 4. Lower back to the starting position.', 'http://example.com/seated_calf_raise.jpg'),
( 'Box Jump', '1. Stand in front of a sturdy box or bench. 2. Jump onto the box, landing softly. 3. Step back down to the starting position.', 'http://example.com/box_jump.jpg'),
( 'Goblet Squat', '1. Stand with feet shoulder-width apart, holding a dumbbell at chest height. 2. Lower your body into a squat. 3. Return to the starting position.', 'http://example.com/goblet_squat.jpg'),
( 'Walking Lunge', '1. Stand with feet hip-width apart, holding dumbbells. 2. Step forward with one leg and lower your body. 3. Step forward with the other leg and repeat.', 'http://example.com/walking_lunge.jpg'),
( 'Reverse Lunge', '1. Stand with feet hip-width apart, holding dumbbells. 2. Step backward with one leg and lower your body. 3. Return to the starting position.', 'http://example.com/reverse_lunge.jpg'),
( 'Side Lunge', '1. Stand with feet together, holding dumbbells. 2. Step out to the side with one leg and lower your body. 3. Return to the starting position.', 'http://example.com/side_lunge.jpg'),
( 'Pistol Squat', '1. Stand on one leg with the other extended in front of you. 2. Lower your body into a squat. 3. Return to the starting position.', 'http://example.com/pistol_squat.jpg'),
( 'Mountain Climber', '1. Start in a plank position. 2. Bring one knee towards your chest, then switch legs quickly.', 'http://example.com/mountain_climber.jpg'),
( 'Plank', '1. Start in a push-up position with your forearms on the floor. 2. Hold your body in a straight line.', 'http://example.com/plank.jpg'),
( 'Side Plank', '1. Lie on your side with one forearm on the floor. 2. Lift your hips until your body is in a straight line. 3. Hold the position.', 'http://example.com/side_plank.jpg'),
( 'Bicycle Crunch', '1. Lie on your back with hands behind your head. 2. Bring one knee towards your chest while lifting your shoulders. 3. Twist your torso to touch the opposite elbow to the knee. 4. Repeat on the other side.', 'http://example.com/bicycle_crunch.jpg'),
( 'Russian Twist', '1. Sit on the floor with knees bent, holding a weight. 2. Lean back slightly and twist your torso from side to side.', 'http://example.com/russian_twist.jpg'),
( 'Hanging Leg Raise', '1. Hang from a pull-up bar. 2. Raise your legs until they are parallel to the floor. 3. Lower back to the starting position.', 'http://example.com/hanging_leg_raise.jpg'),
( 'Hanging Knee Raise', '1. Hang from a pull-up bar. 2. Raise your knees towards your chest. 3. Lower back to the starting position.', 'http://example.com/hanging_knee_raise.jpg'),
( 'Cable Crunch', '1. Kneel facing a cable machine with a rope attachment. 2. Hold the rope and curl your torso down. 3. Return to the starting position.', 'http://example.com/cable_crunch.jpg'),
( 'Ab Wheel Rollout', '1. Kneel on the floor holding an ab wheel. 2. Roll the wheel forward while keeping your body straight. 3. Return to the starting position.', 'http://example.com/ab_wheel_rollout.jpg'),
( 'Dragon Flag', '1. Lie on a bench, holding onto the bench behind your head. 2. Lift your legs and torso until they are vertical. 3. Lower back to the starting position.', 'http://example.com/dragon_flag.jpg'),
( 'Hollow Hold', '1. Lie on your back with arms extended overhead. 2. Lift your legs and shoulders off the floor. 3. Hold the position.', 'http://example.com/hollow_hold.jpg'),
( 'V-Up', '1. Lie on your back with arms extended overhead. 2. Lift your legs and torso to form a V shape. 3. Return to the starting position.', 'http://example.com/v_up.jpg'),
( 'Toe Touch', '1. Lie on your back with legs extended towards the ceiling. 2. Reach your hands towards your toes. 3. Return to the starting position.', 'http://example.com/toe_touch.jpg'),
( 'Crunch', '1. Lie on your back with knees bent and hands behind your head. 2. Lift your shoulders off the floor. 3. Return to the starting position.', 'http://example.com/crunch.jpg'),
( 'Sit-Up', '1. Lie on your back with knees bent and feet flat on the floor. 2. Lift your torso to a sitting position. 3. Return to the starting position.', 'http://example.com/sit_up.jpg'),
( 'Flutter Kick', '1. Lie on your back with legs extended. 2. Lift your legs and alternate kicking them up and down.', 'http://example.com/flutter_kick.jpg'),
( 'Scissor Kick', '1. Lie on your back with legs extended. 2. Lift your legs and alternate crossing them over each other.', 'http://example.com/scissor_kick.jpg'),
( 'Standing Calf Raise', '1. Stand with feet shoulder-width apart. 2. Raise your heels to stand on your tiptoes. 3. Lower back to the starting position.', 'http://example.com/standing_calf_raise.jpg'),
( 'Sled Push', '1. Stand behind a weighted sled. 2. Push the sled forward.', 'http://example.com/sled_push.jpg'),
( 'Sled Pull', '1. Stand in front of a weighted sled with a harness. 2. Pull the sled forward.', 'http://example.com/sled_pull.jpg'),
( 'Farmer''s Walk', '1. Stand with feet shoulder-width apart, holding heavy weights. 2. Walk forward while keeping your back straight.', 'http://example.com/farmers_walk.jpg'),
( 'Overhead Carry', '1. Stand with feet shoulder-width apart, holding weights overhead. 2. Walk forward while keeping your arms extended.', 'http://example.com/overhead_carry.jpg'),
( 'Suitcase Carry', '1. Stand with feet shoulder-width apart, holding a weight in one hand. 2. Walk forward while keeping your back straight.', 'http://example.com/suitcase_carry.jpg'),
( 'Sandbag Clean', '1. Stand with feet shoulder-width apart, holding a sandbag. 2. Lift the sandbag to shoulder height. 3. Return to the starting position.', 'http://example.com/sandbag_clean.jpg'),
( 'Sandbag Squat', '1. Stand with feet shoulder-width apart, holding a sandbag at chest height. 2. Lower your body into a squat. 3. Return to the starting position.', 'http://example.com/sandbag_squat.jpg'),
( 'Sandbag Deadlift', '1. Stand with feet shoulder-width apart, holding a sandbag. 2. Lift the sandbag by extending your hips and knees. 3. Return to the starting position.', 'http://example.com/sandbag_deadlift.jpg'),
( 'Medicine Ball Slam', '1. Stand with feet shoulder-width apart, holding a medicine ball. 2. Lift the ball overhead and slam it to the floor. 3. Pick up the ball and repeat.', 'http://example.com/medicine_ball_slam.jpg'),
( 'Medicine Ball Chest Pass', '1. Stand with feet shoulder-width apart, holding a medicine ball. 2. Throw the ball forward from chest height.', 'http://example.com/medicine_ball_chest_pass.jpg'),
( 'Medicine Ball Sit-Up', '1. Lie on your back with knees bent, holding a medicine ball. 2. Perform a sit-up while holding the ball. 3. Return to the starting position.', 'http://example.com/medicine_ball_sit_up.jpg'),
( 'Medicine Ball Russian Twist', '1. Sit on the floor with knees bent, holding a medicine ball. 2. Lean back slightly and twist your torso from side to side.', 'http://example.com/medicine_ball_russian_twist.jpg'),
(' Rope Wave', '1. Stand with feet shoulder-width apart, holding battle ropes. 2. Move your arms up and down to create waves in the ropes.', 'http://example.com/battle_rope_wave.jpg'),
( 'Battle Rope Slam', '1. Stand with feet shoulder-width apart, holding battle ropes. 2. Lift the ropes overhead and slam them to the ground.', 'http://example.com/battle_rope_slam.jpg'),
( 'Battle Rope Circles', '1. Stand with feet shoulder-width apart, holding battle ropes. 2. Move your arms in circles to create circular waves in the ropes.', 'http://example.com/battle_rope_circles.jpg'),
( 'Battle Rope Snakes', '1. Stand with feet shoulder-width apart, holding battle ropes. 2. Move your arms side to side to create snake-like waves in the ropes.', 'http://example.com/battle_rope_snakes.jpg'),
( 'Battle Rope Jumping Jacks', '1. Stand with feet together, holding battle ropes. 2. Jump your feet out while raising your arms, then jump back to the starting position.', 'http://example.com/battle_rope_jumping_jacks.jpg'),
( 'Battle Rope Burpee', '1. Stand with feet shoulder-width apart, holding battle ropes. 2. Perform a burpee while holding the ropes.', 'http://example.com/battle_rope_burpee.jpg'),
( 'Kettlebell Clean', '1. Stand with feet shoulder-width apart, holding a kettlebell. 2. Lift the kettlebell to shoulder height. 3. Return to the starting position.', 'http://example.com/kettlebell_clean.jpg'),
( 'Kettlebell Snatch', '1. Stand with feet shoulder-width apart, holding a kettlebell. 2. Lift the kettlebell overhead in one motion. 3. Return to the starting position.', 'http://example.com/kettlebell_snatch.jpg'),
( 'Kettlebell Turkish Get-Up', '1. Lie on your back, holding a kettlebell overhead. 2. Rise to a standing position while keeping the kettlebell overhead. 3. Return to the starting position.', 'http://example.com/kettlebell_turkish_get_up.jpg'),
( 'Kettlebell Goblet Squat', '1. Stand with feet shoulder-width apart, holding a kettlebell at chest height. 2. Lower your body into a squat. 3. Return to the starting position.', 'http://example.com/kettlebell_goblet_squat.jpg'),
( 'Kettlebell Windmill', '1. Stand with feet shoulder-width apart, holding a kettlebell overhead. 2. Bend at the hips while keeping the kettlebell overhead. 3. Return to the starting position.', 'http://example.com/kettlebell_windmill.jpg'),
( 'Kettlebell Deadlift', '1. Stand with feet shoulder-width apart, holding a kettlebell. 2. Lift the kettlebell by extending your hips and knees. 3. Return to the starting position.', 'http://example.com/kettlebell_deadlift.jpg'),
( 'Kettlebell High Pull', '1. Stand with feet shoulder-width apart, holding a kettlebell. 2. Lift the kettlebell to chest height. 3. Return to the starting position.', 'http://example.com/kettlebell_high_pull.jpg'),
( 'Kettlebell Halo', '1. Stand with feet shoulder-width apart, holding a kettlebell. 2. Move the kettlebell around your head in a circular motion.', 'http://example.com/kettlebell_halo.jpg'),
( 'Kettlebell Figure 8', '1. Stand with feet shoulder-width apart, holding a kettlebell. 2. Pass the kettlebell between your legs in a figure 8 pattern.', 'http://example.com/kettlebell_figure_8.jpg'),
( 'Kettlebell Push Press', '1. Stand with feet shoulder-width apart, holding a kettlebell at shoulder height. 2. Press the kettlebell overhead. 3. Return to the starting position.', 'http://example.com/kettlebell_push_press.jpg'),
( 'Landmine Row', '1. Stand with feet shoulder-width apart, holding a landmine barbell. 2. Pull the barbell towards your torso. 3. Return to the starting position.', 'http://example.com/landmine_row.jpg'),
( 'Landmine Lateral Raise', '1. Stand with feet shoulder-width apart, holding a landmine barbell. 2. Raise the barbell out to the side. 3. Return to the starting position.', 'http://example.com/landmine_lateral_raise.jpg'),
( 'Landmine Squat Press', '1. Stand with feet shoulder-width apart, holding a landmine barbell at chest height. 2. Lower your body into a squat. 3. Press the barbell overhead as you stand up.', 'http://example.com/landmine_squat_press.jpg'),
( 'Landmine Deadlift', '1. Stand with feet shoulder-width apart, holding a landmine barbell. 2. Lift the barbell by extending your hips and knees. 3. Return to the starting position.', 'http://example.com/landmine_deadlift.jpg'),
( 'Landmine Reverse Lunge', '1. Stand with feet shoulder-width apart, holding a landmine barbell at chest height. 2. Step backward with one leg and lower your body. 3. Return to the starting position.', 'http://example.com/landmine_reverse_lunge.jpg'),
( 'Landmine Single-Leg Deadlift', '1. Stand with feet shoulder-width apart, holding a landmine barbell. 2. Lift one leg and bend at the hips to lower the barbell. 3. Return to the starting position.', 'http://example.com/landmine_single_leg_deadlift.jpg'),
( 'Smith Machine Chest Press', '1. Lie on a bench under a Smith machine bar. 2. Grip the bar with hands slightly wider than shoulder-width apart. 3. Press the bar up until your arms are fully extended. 4. Lower back to the starting position.', 'http://example.com/smith_machine_chest_press.jpg'),
( 'Smith Machine Squat', '1. Stand under the bar of a Smith machine, feet shoulder-width apart. 2. Lower your body into a squat. 3. Return to the starting position.', 'http://example.com/smith_machine_squat.jpg'),
( 'Smith Machine Overhead Press', '1. Stand under the bar of a Smith machine, feet shoulder-width apart. 2. Press the bar overhead. 3. Return to the starting position.', 'http://example.com/smith_machine_overhead_press.jpg'),
( 'Smith Machine Shrug', '1. Stand under the bar of a Smith machine, feet shoulder-width apart. 2. Lift your shoulders towards your ears. 3. Return to the starting position.', 'http://example.com/smith_machine_shrug.jpg');

INSERT INTO exercise_muscles (exercise_id, muscle_id) VALUES
(33, 3), -- Reverse Fly - Shoulders
(33, 4), -- Reverse Fly - Biceps
(34, 2), -- Lat Pulldown - Back
(34, 4), -- Lat Pulldown - Biceps
(35, 4), -- Preacher Curl - Biceps
(36, 6), -- Leg Press - Quads
(36, 7), -- Leg Press - Hamstrings
(36, 9), -- Leg Press - Glutes
(37, 6), -- Leg Extension - Quads
(38, 7), -- Leg Curl - Hamstrings
(39, 9), -- Hip Thrust - Glutes
(39, 7), -- Hip Thrust - Hamstrings
(40, 9), -- Glute Bridge - Glutes
(40, 7), -- Glute Bridge - Hamstrings
(41, 6), -- Step-Up - Quads
(41, 7), -- Step-Up - Hamstrings
(41, 9), -- Step-Up - Glutes
(42, 6), -- Bulgarian Split Squat - Quads
(42, 7), -- Bulgarian Split Squat - Hamstrings
(42, 9), -- Bulgarian Split Squat - Glutes
(43, 6), -- Single-Leg Squat - Quads
(43, 7), -- Single-Leg Squat - Hamstrings
(43, 9), -- Single-Leg Squat - Glutes
(44, 8), -- Calf Raise - Calves
(45, 8), -- Seated Calf Raise - Calves
(46, 6), -- Box Jump - Quads
(46, 7), -- Box Jump - Hamstrings
(46, 9), -- Box Jump - Glutes
(47, 6), -- Goblet Squat - Quads
(47, 7), -- Goblet Squat - Hamstrings
(47, 9), -- Goblet Squat - Glutes
(48, 6), -- Walking Lunge - Quads
(48, 7), -- Walking Lunge - Hamstrings
(48, 9), -- Walking Lunge - Glutes
(49, 6), -- Reverse Lunge - Quads
(49, 7), -- Reverse Lunge - Hamstrings
(49, 9), -- Reverse Lunge - Glutes
(50, 6), -- Side Lunge - Quads
(50, 7), -- Side Lunge - Hamstrings
(50, 9), -- Side Lunge - Glutes
(51, 6), -- Pistol Squat - Quads
(51, 7), -- Pistol Squat - Hamstrings
(51, 9), -- Pistol Squat - Glutes
(52, 10), -- Mountain Climber - Abs
(52, 6), -- Mountain Climber - Quads
(53, 10), -- Plank - Abs
(54, 10), -- Side Plank - Abs
(55, 10), -- Bicycle Crunch - Abs
(56, 10), -- Russian Twist - Abs
(57, 10), -- Hanging Leg Raise - Abs
(58, 10), -- Hanging Knee Raise - Abs
(59, 10), -- Cable Crunch - Abs
(60, 10), -- Ab Wheel Rollout - Abs
(61, 10), -- Dragon Flag - Abs
(62, 10), -- Hollow Hold - Abs
(63, 10), -- V-Up - Abs
(64, 10), -- Toe Touch - Abs
(65, 10), -- Crunch - Abs
(66, 10), -- Sit-Up - Abs
(67, 10), -- Flutter Kick - Abs
(68, 10), -- Scissor Kick - Abs
(69, 8), -- Standing Calf Raise - Calves
(70, 6), -- Sled Push - Quads
(70, 7), -- Sled Push - Hamstrings
(70, 9), -- Sled Push - Glutes
(71, 6), -- Sled Pull - Quads
(71, 7), -- Sled Pull - Hamstrings
(71, 9), -- Sled Pull - Glutes
(72, 2), -- Farmer's Walk - Back
(72, 6), -- Farmer's Walk - Quads
(72, 7), -- Farmer's Walk - Hamstrings
(72, 9), -- Farmer's Walk - Glutes
(73, 2), -- Overhead Carry - Back
(73, 6), -- Overhead Carry - Quads
(73, 7), -- Overhead Carry - Hamstrings
(73, 9), -- Overhead Carry - Glutes
(74, 2), -- Suitcase Carry - Back
(74, 6), -- Suitcase Carry - Quads
(74, 7), -- Suitcase Carry - Hamstrings
(74, 9), -- Suitcase Carry - Glutes
(75, 2), -- Sandbag Clean - Back
(75, 6), -- Sandbag Clean - Quads
(75, 7), -- Sandbag Clean - Hamstrings
(75, 9), -- Sandbag Clean - Glutes
(76, 6), -- Sandbag Squat - Quads
(76, 7), -- Sandbag Squat - Hamstrings
(76, 9), -- Sandbag Squat - Glutes
(77, 2), -- Sandbag Deadlift - Back
(77, 6), -- Sandbag Deadlift - Quads
(77, 7), -- Sandbag Deadlift - Hamstrings
(77, 9), -- Sandbag Deadlift - Glutes
(78, 3), -- Medicine Ball Slam - Shoulders
(78, 10), -- Medicine Ball Slam - Abs
(79, 4), -- Medicine Ball Chest Pass - Biceps
(79, 3), -- Medicine Ball Chest Pass - Shoulders
(80, 10), -- Medicine Ball Sit-Up - Abs
(81, 10), -- Medicine Ball Russian Twist - Abs
(82, 3), -- Battle Rope Wave - Shoulders
(82, 4), -- Battle Rope Wave - Biceps
(82, 10), -- Battle Rope Wave - Abs
(83, 3), -- Battle Rope Slam - Shoulders
(83, 4), -- Battle Rope Slam - Biceps
(83, 10), -- Battle Rope Slam - Abs
(84, 3), -- Battle Rope Circles - Shoulders
(84, 4), -- Battle Rope Circles - Biceps
(84, 10), -- Battle Rope Circles - Abs
(85, 3), -- Battle Rope Snakes - Shoulders
(85, 4), -- Battle Rope Snakes - Biceps
(85, 10), -- Battle Rope Snakes - Abs
(86, 3), -- Battle Rope Jumping Jacks - Shoulders
(86, 4), -- Battle Rope Jumping Jacks - Biceps
(86, 10), -- Battle Rope Jumping Jacks - Abs
(87, 3), -- Battle Rope Burpee - Shoulders
(87, 4), -- Battle Rope Burpee - Biceps
(87, 10), -- Battle Rope Burpee - Abs
(88, 2), -- Kettlebell Clean - Back
(88, 6), -- Kettlebell Clean - Quads
(88, 7), -- Kettlebell Clean - Hamstrings
(88, 9), -- Kettlebell Clean - Glutes
(89, 2), -- Kettlebell Snatch - Back
(89, 6), -- Kettlebell Snatch - Quads
(89, 7), -- Kettlebell Snatch - Hamstrings
(89, 9), -- Kettlebell Snatch - Glutes
(90, 2), -- Kettlebell Turkish Get-Up - Back
(90, 6), -- Kettlebell Turkish Get-Up - Quads
(90, 7), -- Kettlebell Turkish Get-Up - Hamstrings
(90, 9), -- Kettlebell Turkish Get-Up - Glutes
(91, 6), -- Kettlebell Goblet Squat - Quads
(91, 7), -- Kettlebell Goblet Squat - Hamstrings
(91, 9), -- Kettlebell Goblet Squat - Glutes
(92, 2), -- Kettlebell Windmill - Back
(92, 6), -- Kettlebell Windmill - Quads
(92, 7), -- Kettlebell Windmill - Hamstrings
(92, 9), -- Kettlebell Windmill - Glutes
(93, 2), -- Kettlebell Deadlift - Back
(93, 6), -- Kettlebell Deadlift - Quads
(93, 7), -- Kettlebell Deadlift - Hamstrings
(93, 9), -- Kettlebell Deadlift - Glutes
(94, 2), -- Kettlebell High Pull - Back
(94, 6), -- Kettlebell High Pull - Quads
(94, 7), -- Kettlebell High Pull - Hamstrings
(94, 9), -- Kettlebell High Pull - Glutes
(95, 3), -- Kettlebell Halo - Shoulders
(95, 4), -- Kettlebell Halo - Biceps
(96, 3), -- Kettlebell Figure 8 - Shoulders
(96, 4), -- Kettlebell Figure 8 - Biceps
(97, 3), -- Kettlebell Push Press - Shoulders
(97, 4), -- Kettlebell Push Press - Biceps
(98, 2), -- Landmine Row - Back
(99, 3), -- Landmine Lateral Raise - Shoulders
(99, 4), -- Landmine Lateral Raise - Biceps
(100, 3), -- Landmine Squat Press - Shoulders
(100, 6), -- Landmine Squat Press - Quads
(100, 7), -- Landmine Squat Press - Hamstrings
(100, 9), -- Landmine Squat Press - Glutes
(101, 2), -- Landmine Deadlift - Back
(101, 6), -- Landmine Deadlift - Quads
(101, 7), -- Landmine Deadlift - Hamstrings
(101, 9), -- Landmine Deadlift - Glutes
(102, 2), -- Landmine Reverse Lunge - Back
(102, 6), -- Landmine Reverse Lunge - Quads
(102, 7), -- Landmine Reverse Lunge - Hamstrings
(102, 9), -- Landmine Reverse Lunge - Glutes
(103, 2), -- Landmine Single-Leg Deadlift - Back
(103, 6), -- Landmine Single-Leg Deadlift - Quads
(103, 7), -- Landmine Single-Leg Deadlift - Hamstrings
(103, 9), -- Landmine Single-Leg Deadlift - Glutes
(104, 1), -- Smith Machine Chest Press - Chest
(105, 6), -- Smith Machine Squat - Quads
(105, 7), -- Smith Machine Squat - Hamstrings
(105, 9), -- Smith Machine Squat - Glutes
(106, 3), -- Smith Machine Overhead Press - Shoulders
(106, 4), -- Smith Machine Overhead Press - Biceps
(107, 3), -- Smith Machine Shrug - Shoulders
(107, 4); -- Smith Machine Shrug - Biceps