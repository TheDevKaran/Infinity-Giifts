const dotenv = require('dotenv');
dotenv.config();
//IMPORT EXTERNAL PACKAGES
//same like import 'package:express/express.dart'
const express = require('express'); 
const mongoose = require('mongoose');


// require('dotenv').config(); // 

//IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth_routes");
const adminRouter = require("./routes/admin_routes");
const productRouter = require('./routes/products_routes');
const userRouter = require('./routes/user_routes');

//INIT
const app = express();


 //MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);  

//connections
mongoose.connect(process.env.DB)
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


app.listen(process.env.PORT, "0.0.0.0", ()=>{console.log(`connected at port ${process.env.PORT}`);});
//localhost