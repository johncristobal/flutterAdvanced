const { response } = require('express');
const { validateToken } = require('../helpers/verify-token');
const AppleAuth = require("apple-auth");
const jwt = require("jsonwebtoken");
const fs = require('fs');

const googleAuth = async (req, res = response) => {

    try{
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
    catch(err){
        return res.json({
            ok: false,
            err
        })
    }
    
}

const appleSign = async (request, response) => {
    const redirect = `intent://callback?${new URLSearchParams(
        request.body
    ).toString()}#Intent;package=${
        process.env.ANDROID_PACKAGE_IDENTIFIER
    };scheme=signinwithapple;end`;

    console.log(`Redirecting to ${redirect}`);

    response.redirect(307, redirect);
}

const signInApple = async (request, response) => {
    const auth = new AppleAuth(
    {
    // use the bundle ID as client ID for native apps, else use the service ID for web-auth flows
    // https://forums.developer.apple.com/thread/118135
    client_id:
        request.query.useBundleId === "true"
        ? process.env.BUNDLE_ID
        : process.env.SERVICE_ID,
    team_id: process.env.TEAM_ID,
    redirect_uri:
        "https://flutteradvancedjohn.herokuapp.com/callbacks/sign_in_with_apple", // does not matter here, as this is already the callback that verifies the token after the redirection
    key_id: process.env.KEY_ID
    },
    //process.env.KEY_CONTENTS.replace(/\|/g, "\n"),
    fs.readFileSync('./keys/authkeys.p8').toString(),
    "text"
    );

    console.log(request.query);

    const accessToken = await auth.accessToken(request.query.code);

    const idToken = jwt.decode(accessToken.id_token);

    const userID = idToken.sub;

    console.log(idToken);

    // `userEmail` and `userName` will only be provided for the initial authorization with your app
    const userEmail = idToken.email;
    const userName = `${request.query.firstName} ${request.query.lastName}`;

    // 👷🏻‍♀️ TODO: Use the values provided create a new session for the user in your system
    const sessionID = `NEW SESSION ID for ${userID} / ${userEmail} / ${userName}`;

    console.log(`sessionID = ${sessionID}`);

    response.json({ sessionId: sessionID });
}

module.exports = {
    googleAuth,
    appleSign,
    signInApple
}