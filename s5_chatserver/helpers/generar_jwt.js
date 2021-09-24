const jwt = require("jsonwebtoken");

const generarjwt = ( uid ) => {

    return new Promise( (resolve, reject) => {
        const payload = { uid };

        jwt.sign( payload, process.env.SECRET_KEY, {
            expiresIn: '24h',
        }, (err, token) => {
            if(err){                
                reject("Error generar jwt"); //error
            }else{                
                resolve(token); //tooken ok
            }
        });
    })
}

module.exports = {
    generarjwt
}
