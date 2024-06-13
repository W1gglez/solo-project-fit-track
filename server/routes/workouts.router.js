const express = require('express');
const pool = require('../modules/pool');
const router = express.Router();
const {
  rejectUnauthenticated,
} = require('../modules/authentication-middleware');

router.get('/', rejectUnauthenticated, async (req, res) => {
  const query = `SELECT workout_log.date, exercises."name" as exercise_name , workout_details."sets", workout_details.reps, workout_details.weight FROM workout_log 
JOIN workout_details ON workout_details.workout_id = workout_log.id 
JOIN exercises ON workout_details.exercise_id = exercises.id
WHERE user_id=$1;`;
  try {
    const result = await pool.query(query, [req.user.id]);
    res.send(result.rows).status(201);
  } catch (err) {
    console.error('Error processing /GET workout', err);
  }
});

/**
 * POST route template
 */
router.post('/', rejectUnauthenticated, (req, res) => {
  // POST route code here
});

module.exports = router;
