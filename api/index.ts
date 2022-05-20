declare var require: any

require('dotenv').config();
const { Pool } = require('pg');
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const env = process.env.NODE_ENV || 'development';

enum listingStatus {
    Active = 'Active',
    Booked = 'Booked',
    Expired = 'Expired'
}

if (env === 'development') {
    var pgConnectionString = `postgresql://${process.env.PG_USER}:${process.env.PG_PASSWORD}@${process.env.PG_HOST}:${process.env.PG_PORT}/${process.env.PG_DATABASE}`;
}

if (env === 'production') {
    //TODO: add production config
}

const pool = new Pool({
    connectionString: pgConnectionString,
    ssl: {
        rejectUnauthorized: false
    }
});

app.use(express.json());

/*** Version 1 endpoints */

app.get('/v1/', (req, res) => {
    console.log('GET /v1/');
    res.send({
        name: 'Hytch API',
        version: '1.0.0',
        description: 'Version 1 of the Hytch API',
    });
});

app.get('/v1/users', (req, res) => {
    const { uid } = req.query;
    let sql = 'SELECT * FROM users';
    if (uid) {
        sql = `SELECT * FROM users WHERE user_id = '${uid}'`
    };
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json(result.rows);
    });
});

app.post('/v1/users', (req, res) => {
    const { 
        userId,
        firstName,
        lastName,
        dob,
        bio,
        isHitcher,
        status
    } = req.body;
    let sql = `INSERT INTO users (user_id, first_name, last_name, dob, bio, is_hitcher, status) VALUES 
        ('${userId}', '${firstName}', '${lastName || ''}', ${dob || null}, '${bio || ''}', 
        ${isHitcher || true}, '${status || ''}');`;
    pool.query(sql, (err, result) => {
        if (err) {
            res.status(400).send(err);
            console.log(err);
        } else {
            res.json({status: 200, message: 'New user added'});
        }
    });
});

app.delete('/v1/users/:userId', (req, res) => {
    const { userId } = req.params;
    let sql = `DELETE FROM users WHERE user_id = ${userId}; DELETE FROM chats WHERE hitcher = ${userId} or driver = ${userId}; DELETE FROM messages WHERE sender = ${userId}`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json({status: 200, message: 'Account deleted'});
    });
});

app.get('/v1/messages/:chatId', (req, res) => {
    const { chatId } = req.params;
    let sql = `SELECT * FROM messages WHERE chat_id = ${chatId};`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json(result.rows);
    });
});

app.post('/v1/messages', (req, res) => {
    const { 
        chatId,
        sender,
        mediaURI,
        timeSent,
        systemMessage,
    } = req.body;
    let sql = `INSERT INTO messages (chat_id, sender, media, time_sent, system_message) VALUES (${chatId}, ${sender}, ${mediaURI}, ${timeSent}, ${systemMessage});`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json({status: 200, message: 'Message sent'});
    });
});

app.get('/v1/trips/:tripId', (req, res) => {
    const { tripId } = req.params;
    if (!Number.isInteger( parseInt(tripId) )) {
        res.status(400).send({message: 'Invalid trip id'});
        return;
    }
    let sql = `SELECT * FROM trips WHERE id = ${tripId};`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json(result.rows);
    });
});

app.delete('/v1/trips/:tripId', (req, res) => {
    const { tripId } = req.params;
    let sql = `DELETE FROM trips WHERE id = ${tripId};`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json({status: 200, message: 'Trip deleted'});
    });
});

app.post('/v1/trips', (req, res) => {
    const { 
        driver,
        arrivalTime,
        departureTime,
        startLocation,
        endLocation,
        seatsAvailable,
        pricePerSeat,
        description
    } = req.body;
    let sql = `INSERT INTO trips (driver, arrival_time, departure_time, description, start_location, end_location, seats_available, price_per_seat) VALUES (${driver}, ${arrivalTime}, ${departureTime}, ${description}, ${startLocation}, ${endLocation}, ${seatsAvailable}, ${pricePerSeat} ) );`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json({status: 200, message: 'Trip added'});
    });
});

app.get('/v1/listings', (req, res) => {
    const { status, lister } = req.query;
    let sql = '';
    if (Object.values(listingStatus).includes(status)) {
        sql = `SELECT * FROM listings WHERE status = '${status}';`;
    }
    if (lister) {
        sql = `SELECT * FROM listings WHERE lister = ${lister};`;
    }
    if (Object.values(listingStatus).includes(status) && lister) {
        sql = `SELECT * FROM listings where status = ${status} and lister = ${lister};`;
    }
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json(result.rows);
    });
});

app.delete('/v1/listings/:id', (req, res) => {
    const { id } = req.params;
    if (Number.isInteger(id)) {
        res.status(400).send({
            message: 'Missing id',
        });
    }
    let sql = `DELETE FROM listings WHERE id = ${id};`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json({status: 200, message: 'Listing deleting'});
    });
});

app.post('/v1/listings', (req, res) => {
    const { lister, status, tripId } = req.query;
    let sql = `INSERT INTO listings (lister, status, trip_id) VALUES (${lister}, ${status}, ${tripId});`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json({status: 200, message: 'New listing added'});
    });
});

app.get('/v1/sanction', (req, res) => {
    const { userId } = req.query;
    let sql = `SELECT * FROM sanctions WHERE user_id = ${userId};`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json(result.rows);
    });
});

app.post('/v1/sanction', (req, res) => {
    const { userId, description } = req.body;
    let startDate = new Date();
    let endDate = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate() + 90);
    let sql = `INSERT INTO sanctions (user_id, start_date, end_date, description) VALUES (${userId}, '${startDate}', '${endDate}', ${description});`;
    pool.query(sql, (err, result) => {
        if (err) throw err;
        res.json(result.rows);
    });
});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});