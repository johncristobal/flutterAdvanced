//api/login
const { Router, response } = require("express");
const { check } = require("express-validator");
const { crearUser, loginUser, renovarToken } = require("../controllers/auth");
const { validarCampos } = require("../middlewares/validar_campos");
const { validarJWT } = require("../middlewares/validar_jwt");

const router = Router();

router.post("/new",[
    check("nombre","Nombre obligatorio").not().isEmpty(),
    check("email","Correo obligatorio").isEmail(),
    check("password","Contraseña obligatorio").not().isEmpty(),
    validarCampos
], crearUser);

router.post("/",[
    check("email","Correo obligatorio").isEmail(),
    check("password","Contraseña obligatorio").not().isEmpty(),
    validarCampos
], loginUser);

router.get("/renew", validarJWT, renovarToken);

module.exports = router;