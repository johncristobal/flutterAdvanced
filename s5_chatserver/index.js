const express = require('express');
const path = require('path');
const { dbConnection } = require('./database/config');
require('dotenv').config();

//dbconfig
dbConnection();

// App de Express
const app = express();

//lectura body y parse
app.use( express.json());

// Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/socket');

// Path público
const publicPath = path.resolve( __dirname, 'public' );
app.use( express.static( publicPath ) );

//rutas
app.use( '/api/login', require("./routes/auth") );
app.use( '/api/usuarios', require("./routes/usuarios") );

server.listen( process.env.PORT, ( err ) => {
    if ( err ) throw new Error(err);
    console.log('Servidor corriendo en puerto', process.env.PORT );
});


