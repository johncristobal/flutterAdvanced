const { v4: uuidV4 } = require("uuid");

class Band { 

    constructor( name = "noname"){

        this.id = uuidV4();
        this.name = name;
        this.votes = 0;
    }
}
 
module.exports = Band;
