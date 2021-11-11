const express = require('express');
const bodyParser = require('body-parser');
require('dotenv').config();

const app = express();

//bodyparse
app.use( bodyParser.urlencoded({extended: true}));

app.use('/', require('./routes/auth'));

app.listen( process.env.PORT, () => {
    console.log('Servidor en puerto - ', process.env.PORT);
})