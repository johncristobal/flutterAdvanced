const express = require('express');
const path = require('path');
require('dotenv').config();

const app = express();

//servidor sockets node
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/sockets');

//public
const publicpath = path.resolve( __dirname, 'public' );
app.use(express.static(publicpath));

//puerto
server.listen(process.env.PORT, (err) => {
    if( err ) throw new Error(err);
    console.log('Running on 3001')
});