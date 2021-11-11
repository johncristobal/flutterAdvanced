const { response } = require('express');
const { validateToken } = require('../helpers/verify-token');

const googleAuth = async (req, res = response) => {

    const token = req.body.token; 

    if(!token){
        return res.json({
            ok: false,
            msg: 'Sin token'
        })
    }

    const googleuser = await validateToken(token);
    if(!googleuser){
        return res.json({
            ok: false,
        })
    }

    res.json({
        ok: true,
        googleuser
    })
}

module.exports = {
    googleAuth
}