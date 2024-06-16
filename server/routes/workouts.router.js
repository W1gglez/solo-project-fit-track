const express = require('express');
const pool = require('../modules/pool');
const router = express.Router();
const {
  rejectUnauthenticated,
} = require('../modules/authentication-middleware');

router.get('/', rejectUnauthenticated, async (req, res) => {
  try {
    const query = `
    SELECT wl.id as workout_id, wl.date, e."name" as exercise_name, wd.id as details_id, 
     ARRAY_AGG(JSON_BUILD_OBJECT(
        'set_id', si.id,
        'set_number', si.set_number,
        'reps', si.reps,
        'weight', si.weight
    )) as set_info
    FROM workout_log wl
    JOIN workout_details wd ON wd.workout_id = wl.id 
    JOIN exercises e ON wd.exercise_id = e.id
    JOIN set_info si ON wd.id = si.detail_id
    WHERE user_id=$1 AND date=$2 
    GROUP BY wl.id, wl.date, wd.id,  e."name";`;

    const date = req.query.date || new Date().toLocaleDateString();

    const result = await pool.query(query, [req.user.id, date]);
    res.send(result.rows).status(200);
  } catch (err) {
    console.error('Error processing /GET workout', err);
    res.sendStatus(500);
  }
});

//Create new workout entry in workout_log for current date
router.post('/add-workout', rejectUnauthenticated, async (req, res) => {
  try {
    const query = `INSERT INTO workout_log ("user_id", date) VALUES ($1, $2);`;
    const date = /*req.query.date ||*/ new Date().toLocaleDateString();

    await pool.query(query, [req.user.id, date]);
    res.sendStatus(201);
  } catch (err) {
    console.error('Error processing POST add-workout', err);
    res.sendStatus(500);
  }
});

//Add new exercise with set info to workout
router.post('/add-workout-details', rejectUnauthenticated, async (req, res) => {
  const { workout_id, exercise_id, set_info } = req.body;

  try {
    //Run check to see if exercise is already in workout
    const checkQuery = `SELECT 1 FROM workout_details WHERE workout_id=$1 AND exercise_id=$2;`;
    const checkResult = await pool.query(checkQuery, [workout_id, exercise_id]);

    if (checkResult.rows.length > 0) {
      // Exercise already exists
      res.status(409).send('Exercise already exists');
    } else {
      //Exercise does not exist - Add Exercise
      const query =
        'INSERT INTO workout_details (workout_id, exercise_id) VALUES ($1, $2) RETURNING id';

      const result = await pool.query(query, [workout_id, exercise_id]);
      try {
        const query =
          'INSERT INTO set_info (detail_id, set_number, reps, weight) VALUES ($1, $2, $3, $4);';

        for (const set of set_info) {
          await pool.query(query, [
            result.rows[0].id,
            set.set_number,
            set.reps,
            set.weight,
          ]);
        }
        res.sendStatus(201);
      } catch (err) {
        console.error('Error processing POST add-workout-details', err);
        res.sendStatus(500);
      }
    }
  } catch (err) {
    console.error('Error processing POST add-workout-details', err);
    res.sendStatus(500);
  }
});

router.put('/set-info/:id', rejectUnauthenticated, (req, res) => {
  //Route for updating set_info
});

router.delete('/remove-excercise/:id', rejectUnauthenticated, (req, res) => {
  //Route for removing exercise from workout
});

module.exports = router;
