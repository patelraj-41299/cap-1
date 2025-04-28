const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

db.connect((err) => {
  if (err) {
    console.error('Database connection failed: ' + err.stack);
    return;
  }
  console.log('Connected to database.');
});

app.use(express.json());
app.use(express.static('frontend'));

app.post('/submit', (req, res) => {
  const { name, email } = req.body;
  db.query('INSERT INTO users (name, email) VALUES (?, ?)', [name, email], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error saving data');
      return;
    }
    res.send('Data saved successfully!');
  });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
