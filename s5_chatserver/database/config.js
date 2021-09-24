const mongoose = require("mongoose");

const dbConnection = async () => {

    try{
        await mongoose.connect(process.env.DB_CNN, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });

        console.log("Db online");
    }catch(e){
        console.log(e);
        throw new Error("Error base datos...");
    }
}

module.exports = {
    dbConnection
}