const { io } = require('../index');
const Band = require('../models/band');
const Bands = require('../models/bands');

const bands = new Bands();
bands.addBand(new Band("Queen"));
bands.addBand(new Band("Norvana"));
bands.addBand(new Band("Metalica"));
bands.addBand(new Band("The cranberries"));

//sockets messages
io.on('connection', client => {
    console.log('Cliente Conectado');

    client.emit( "bandas-activas", bands.getBands() );

    client.on('disconnect', () => { 
        console.log('Cliente desconectado');
    });
    
    client.on('mensaje', (payload) => { 
        console.log(payload);
        io.emit('mensaje', { admin: 'nuevo msg'})
    });

    client.on('emitir-mensaje', (payload) => { 
        console.log(payload);
        client.broadcast.emit('nuevo-mensaje', payload);
    });

    client.on('voto-banda', (payload) => { 
        bands.voteBand( payload.id );
        io.emit( "bandas-activas", bands.getBands() );
    }); 

    client.on('borrar-banda', (payload) => { 
        bands.deleteBand( payload.id );
        io.emit( "bandas-activas", bands.getBands() );
    });

    client.on('crear-banda', (payload) => { 
        bands.addBand(new Band(payload.name));
        io.emit( "bandas-activas", bands.getBands() );
    });
  });
