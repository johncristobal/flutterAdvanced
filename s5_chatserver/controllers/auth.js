const { response } = require("express");
const bcryptjs = require("bcryptjs");

const Usuario = require("../models/usuario");
const { generarjwt } = require("../helpers/generar_jwt");

const crearUser = async (req, res = response) => {

    try{

        const { email, password } = req.body;
        const exists = await Usuario.findOne({ email });
        if(exists){
            return res.status(400).json({
                ok: false,
                msg: 'el correo ya existe'        
            });
        }

        const user = new Usuario( req.body );

        //cifrar pass
        const salt = bcryptjs.genSaltSync();
        user.password = bcryptjs.hashSync(password, salt);

        await user.save();

        //generar jwt
        const token = await generarjwt(user.id);

        res.json({
            ok: true,
            user,
            token
        });

    }catch(e){
        console.log(e);
        res.status(500).json({
            ok: false,
            msg: 'hable con admin'        
        });
    }
}

const loginUser = async (req, res = response) => {

    try{
            
        const { email, password } = req.body;

        const exists = await Usuario.findOne({ email });
        if(!exists){
            return res.status(400).json({
                ok: false,
                msg: 'el correo no existe'        
            });
        }

        //validar pass
        const validPass = bcryptjs.compareSync(password, exists.password);
        if(!validPass){
            return res.status(400).json({
                ok: false,
                msg: 'el pass no es valida'        
            });
        }

        //generar jwt
        const token = await generarjwt(exists.id);

        res.json({
            ok: true,
            user: exists,
            token
        });

    }catch(e){
        console.log(e);
        res.status(500).json({
            ok: false,
            msg: 'hable con admin'        
        });
    }
}

const renovarToken = async (req, res = response) => {

    try{           
        
        //generar jwt
        const token = await generarjwt(req.uid);
        const user = await Usuario.findById(req.uid);

        res.json({
            ok: true,
            user,
            token
        });

    }catch(e){
        console.log(e);
        res.status(500).json({
            ok: false,
            msg: 'hable con admin'        
        });
    }
}

module.exports = {
    crearUser,
    loginUser,
    renovarToken
}