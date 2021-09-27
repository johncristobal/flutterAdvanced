//api/usuarios
const { Router, response } = require("express");
const { getUsuarios } = require("../controllers/usuarios");
const { validarJWT } = require("../middlewares/validar_jwt");

const router = Router();

router.get("/",[
    validarJWT
], getUsuarios);


module.exports = router;