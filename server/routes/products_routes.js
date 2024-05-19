const express = require("express");
const productRouter = express.Router();
const auth = require ("../middlewares/auth_middleware");
const {Product} = require("../models/products");

productRouter.get("/api/products", auth, async (req, res)=>{
    try{
        const products = await Product.find({category: req.query.category});
        res.json(products);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

productRouter.get("/api/products/search/:name", auth, async (req, res) =>{
    try{
        const products = await Product.find({
        name: {$regex : req.params.name, $options: "i"}
        });
        res.json(products);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

productRouter.post("/api/rate-product", auth, async (req, res) => {
    try{
        const {id, rating}= req.body;
        let product = await Product.findById(id);

        if (!product) {
            return res.status(404).json({ error: "Product not found" });
          }
      
          // Initialize ratings array if it doesn't exist
          if (!product.ratings) {
            product.ratings = [];
          }
      
          // Check if the user has already rated the product
          const existingRatingIndex = product.ratings.findIndex(
            (r) => r.userId === req.user
          );
      
          if (existingRatingIndex !== -1) {
            // Update the existing rating
            product.ratings[existingRatingIndex].rating = rating;
          } else {
            // Add a new rating
            product.ratings.push({ userId: req.user, rating });
          }
      
        product = await product.save();
        res.json(product);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

productRouter.get("/api/deal-of-day", auth, async (req, res) =>{
    try{
        let products = await Product.find({});
        products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;
            for(let i =0; i<a.ratings.length; i++){
                aSum+= a.ratings[i].rating;
            }
            for(let i =0; i<b.ratings.length; i++){
                bSum+= b.ratings[i].rating;
            }
            return aSum<bSum ? 1 : -1;
        });
        res.json(products[0]);
    }
    catch(e){

    }
})

module.exports = productRouter;