const express = require('express');
const pool = require('../modules/pool');
const router = express.Router();
const {
  rejectUnauthenticated,
} = require('../modules/authentication-middleware');


router.get('/', rejectUnauthenticated, async (req, res) => {
  // GET route code here
  try {
    const query = `SELECT cl.id as log_id, cl.date, cl.user_id, ARRAY_AGG(JSON_BUILD_OBJECT(
'entry_id',cle.entry_id,
'name',cle.name,
'calories',cle.calories,
'protein',cle.protein,
'carbs',cle.carbs,
'fats',cle.fats
)) as log_entrys 
FROM calorie_log cl JOIN cl_entry cle ON cl.id = cle.log_id 
WHERE user_id=$1 AND date=$2
GROUP BY cl.id, cl.date, cl.user_id;`;
    const date = req.query.date || new Date().toLocaleDateString();

    const result = await pool.query(query, [req.user.id, date]);
    res.send(result.rows).status(200);
  } catch (err) {
    console.error('Error processing /GET calorie_log', err);
    res.sendStatus(500);
  }
});

router.post('/add-log', rejectUnauthenticated, async (req, res) => {
  // POST route code here
  try {
    const query = 'INSERT INTO calorie_log ("user_id", date) VALUES ($1, $2);';
    const date = /*req.query.date ||*/ new Date().toLocaleDateString();

    await pool.query(query, [req.user.id, date]);
    res.sendStatus(201);
  } catch (err) {
    console.error('Error processing POST add-log', err);
    res.sendStatus(500);
  }
});

router.post('/add-log-entry', rejectUnauthenticated, async (req, res) => {
  const { log_id, name, calories } = req.body;
  const protein = req.body.protein || null;
  const carbs = req.body.carbs || null;
  const fats = req.body.fats || null;

  try {
    const query =
      'INSERT INTO cl_entry (log_id, "name" ,calories, protein, carbs, fats) VALUES ($1, $2, $3, $4, $5, $6, $7);';

    await pool.query(query, [log_id, name, calories, protein, carbs, fats]);
    res.sendStatus(201);
  } catch (err) {
    console.error('Error processing POST add-log-entry ', err);
    res.sendStatus(500);
  }
});

router.put('/update-entry/:id', rejectUnauthenticated, async (req, res) => {
  const { name, calories } = req.body;
  const protein = req.body.protein || null;
  const carbs = req.body.carbs || null;
  const fats = req.body.fats || null;

  try {
    const query =
      'UPDATE cl_entry SET name=$2, calories=$3, protein=$4, carbs=$5, fats=$6 WHERE entry_id=$1';

    await pool.query(query, [
      req.params.id,
      name,
      calories,
      protein,
      carbs,
      fats,
    ]);
    res.sendStatus(200);
  } catch (err) {
    console.error(`Error processing PUT update-entry/${req.params.id} `, err);
    res.sendStatus(500);
  }
});

router.delete('/remove-entry/:id', rejectUnauthenticated, async (req, res) => {
  try {
    const query = 'DELETE FROM cl_entry WHERE entry_id=$1';

    await pool.query(query, [req.params.id]);
    res.sendStatus(200);
  } catch (err) {
    console.error(
      `Error processing DELETE remove-entry/${req.params.id} `,
      err
    );
    res.sendStatus(500);
  }
});

module.exports = router;
