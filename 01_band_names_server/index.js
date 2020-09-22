const express = require('express');
const path = require('path');
require('dotenv').config();

//App de express
const app = express();

//Node Server
const server = require('http').createServer();
module.exports.io = require('socket.io')(server);
require('./sockets/socket');



//Path publica
const publicPath = path.relative(__dirname, 'public');
app.use(express.static(publicPath));

server.listen(process.env.PORT, (err) =>{
    if(err) throw new Error(err);
    console.log('Servidro corrientdo en el puerto!!!', process.env.PORT);
});