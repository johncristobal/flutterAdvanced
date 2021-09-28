const { usuarioConectado, usuarioDesconectado, grabarMensaje } = require('../controllers/socket');
const { comprobarJWT } = require('../helpers/generar_jwt');
const { io } = require('../index');


// Mensajes de Sockets
io.on('connection', client => {
    console.log('Cliente conectado');

    const [valido, uid] = comprobarJWT(client.handshake.headers['x-token']);
    console.log(valido);
    if(!valido){
        return client.disconnect();
    }

    //cliente auth
    usuarioConectado(uid);

    //ingtesar a sala - uid mongoose
    //sala global :) io.emit
    client.join( uid );

    //esushcar mensaje-personal
    client.on('mensaje-personal', async (payload) => {
        await grabarMensaje(payload);
        io.to(payload.para).emit('mensaje-personal', payload);
    });

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
        //cliente disconeect
        usuarioDesconectado(uid);
    });

    client.on('mensaje', ( payload ) => {
        console.log('Mensaje', payload);
        io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    });
});
