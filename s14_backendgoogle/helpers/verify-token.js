const { OAuth2Client } = require('google-auth-library');

const CLIENT_ID = '583720077949-mq0b4hqm6h5nkkdgv771ribjdc5ib1su.apps.googleusercontent.com';

const client = new OAuth2Client(CLIENT_ID);

const validateToken = async (token) => {

    try{
        const ticket = await client.verifyIdToken({
            idToken: token,
            audience: [
                CLIENT_ID,
                '583720077949-avv70jp6j5o7r7fdilugj10c14so66gj.apps.googleusercontent.com',
                '583720077949-1g3hf97qu3np6f7r4tbg3ofn1k2r87cd.apps.googleusercontent.com'
            ],  
            // Specify the CLIENT_ID of the app that accesses the backend
            // Or, if multiple clients access the backend:
            //[CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
        });
        const payload = ticket.getPayload();
        console.log(payload);
        return payload;
    //    const userid = payload['sub'];
    }catch(err){
        return err;
    }
    
}

module.exports = {
    validateToken
}