//IMPORT EXTERNAL PACKAGES
//same like import 'package:express/express.dart'
const express = require('express'); 
const mongoose = require('mongoose');

//IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth_routes");
const adminRouter = require("./routes/admin_routes");
const productRouter = require('./routes/products_routes');
const userRouter = require('./routes/user_routes');

//INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb+srv://the_dev_karan:z0ZkDNDYRyGffGFS@lastminutegifts.abusmes.mongodb.net/?retryWrites=true&w=majority&appName=LastMinuteGifts";
const jwt_token = "passwordKey";

 //MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);  

//connections
mongoose
    .connect(DB)
    .then(()=>{
        console.log('connection successful'); 
    })
    .catch((e)=>{
        console.log(e);
    });

// //creating an api
// app.get('/wow', (req, res) => {
//     res.json({hi: "hello workd"});
// });


app.listen(PORT, "0.0.0.0", ()=>{console.log(`connected at port ${PORT}`);});
//localhost