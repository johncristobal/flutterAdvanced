const { io } = require('../index');
//sockets messages
io.on('connection', client => {
    console.log('Cliente Conectado');

    client.on('disconnect', () => { 
        console.log('Cliente desconectado');
    });
    
    client.on('mensaje', (payload) => { 
        console.log(payload);
        io.emit('mensaje', { admin: 'nuevo msg'})
    });
  });
