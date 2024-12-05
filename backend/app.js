const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const app = express();
const port = 3000;

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: '1234',
    port: 5432,
});

app.use(cors()); // Enable CORS
app.use(express.json());

app.get('/planets', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM planets');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Database query failed' });
    }
});

app.listen(port, () => {
    console.log(`Server running on http://192.168.1.10:${port}`);
});
