const { Schema, model } = require("mongoose");

const UsuarioSchema = Schema({

    nombre: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true,
    },
    online: {
        type: Boolean,
        default: false
    }, 
});

UsuarioSchema.method("toJSON", function (){
    const { __v, _id, password, ...rest } = this.toObject();
    rest.uid = _id;
    return rest;
});

module.exports = model("Usuario", UsuarioSchema);