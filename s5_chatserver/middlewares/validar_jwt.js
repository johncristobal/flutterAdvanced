const jwt = require("jsonwebtoken");

const validarJWT = (req,res,next) => {
    const token = req.header("x-token");

    if(!token){
        return res.status(400).json({
            ok: false,
            msg: "No hay token"
        })
    }
    try{

        const { uid } = jwt.verify( token, process.env.SECRET_KEY );
        req.uid = uid;

        next();
    }catch(e){
        console.log(e);
        return res.status(500).json({
            ok: false,
            msg: "token no valido"
        })
    }
}

module.exports = {
    validarJWT
}