const express = require('express');
const pool = require('../modules/pool');
const router = express.Router();
const {
  rejectUnauthenticated,
} = require('../modules/authentication-middleware');

//Return exercises filtered by musclegroup
router.get('/bymusclegroup', async (req, res) => {
  // Validate and get query parameters
  const searchQuery = req.query.search;
  const page = parseInt(req.query.page, 10) || 1;
  const pageSize = 25;

  const query = `
    SELECT exercises.id, "exercises"."name" as exercise_name, STRING_AGG("musclegroups"."name", ', ') as musclegroup_name 
    FROM exercise_muscles
    JOIN exercises ON exercise_muscles.exercise_id = exercises.id 
    JOIN musclegroups ON exercise_muscles.muscle_id = musclegroups.id 
    WHERE "musclegroups"."name" ILIKE $1 
    GROUP BY exercises.id 
    LIMIT $2 
    OFFSET $3;
    `;
  const searchTerm = `%${searchQuery}%`;
  const offset = (page - 1) * pageSize;

  try {
    const result = await pool.query(query, [searchTerm, pageSize, offset]);
    res.send(result.rows);
  } catch (err) {
    console.error('Error processing GET exercises', err);
    res.sendStatus(500);
  }
});

//Returns results containing searchQuery paginated or all results 25 at a time
router.get('/', async (req, res) => {
  // Validate and get query parameters
  const searchQuery = req.query.search || '';
  const page = parseInt(req.query.page, 10) || 1;

  const query = `SELECT exercises.id, exercises.name FROM exercises WHERE name ILIKE $1 ORDER BY id LIMIT 25 OFFSET $2 ;`;
  const searchTerm = `%${searchQuery}%`;
  const offset = (page - 1) * 25;

  try {
    const result = await pool.query(query, [searchTerm, offset]);
    res.send(result.rows);
  } catch (err) {
    console.error('Error processing GET exercises', err);
    res.sendStatus(500);
  }
});


//Given an exercise id returns all fields for that exercise
router.get('/details/:id', async (req, res) => {
  const query = `SELECT exercises.*, ARRAY_AGG(JSON_BUILD_OBJECT(
'step_number',steps.step_number,
'description',steps.description
)) as "steps"
FROM exercises JOIN steps ON steps.exercise_id = exercises.id 
WHERE exercises.id=$1
GROUP BY exercises.id, exercises.name;`;
  try {
    const result = await pool.query(query, [req.params.id]);
    res.send(result.rows);
  } catch (err) {
    console.error(`Error processing GET exercise id:${req.params.id}`, err);
    res.sendStatus(500);
  }
});

// Stretch - Add Exercise from form
router.post('/', rejectUnauthenticated, (req, res) => {
  // POST route code here
});

module.exports = router;
