const express = require("express");
const userRouter = express.Router();
const auth = require('../middlewares/auth_middleware');
const User = require("../models/user");
const { Product } = require("../models/products");
const Order = require("../models/order"); // Make sure you import the Order model

// Add to cart route
userRouter.post("/api/add-to-cart", auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if (user.cart.length === 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;
                    break;
                }
            }
            if (isProductFound) {
                let productInCart = user.cart.find((product) => product.product._id.equals(product._id));
                productInCart.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
        }
        user = await user.save();
        return res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// Remove from cart route
userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    try {
        const { id } = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                if (user.cart[i].quantity === 1) {
                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1;
                }
                break;
            }
        }
        user = await user.save();
        return res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// Save user address route
userRouter.post("/api/save-user-address", auth, async (req, res) => {
    try {
        const { address } = req.body;
        let user = await User.findById(req.user);
        user.address = address;
        user = await user.save();
        return res.json(user);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// Order route
userRouter.post("/api/order", auth, async (req, res) => {
    try {
        const { cart, totalPrice, address } = req.body;
        let products = [];

        for (let i = 0; i < cart.length; i++) {
            let product = await Product.findById(cart[i].product._id);
            if (product.quantity >= cart[i].quantity) {
                product.quantity -= cart[i].quantity;
                products.push({ product, quantity: cart[i].quantity });
                await product.save();
            } else {
                return res.status(400).json({ msg: `${product.name} is out of stock!` });
            }
        }

        let user = await User.findById(req.user);
        user.cart = [];
        user = await user.save();
        res.json(user);

        let order = new Order({
            products,
            totalPrice,
            address,
            userId: req.user,
            orderedAt: new Date().getTime(),
        });

        await order.save(); // Ensure order is saved after user cart is reset and response is sent
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

userRouter.get("/api/orders/me", auth, async (req, res) => {
    try {
        const orders = await Order.find({userId: req.user});
        res.json(orders);
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

module.exports = userRouter;
