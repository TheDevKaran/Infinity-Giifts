const mongoose = require('mongoose');
const { productSchema } = require('./products');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^([a-z0-9\+\._\/&!][-a-z0-9\+\._\/&!]*)@(([a-z0-9][-a-z0-9]*\.)([-a-z0-9]+\.)*[a-z]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email',
        },
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => value.length > 6,
            message: 'Please enter a longer password',
        },
    },
    address: {
        type: String,
        default: ' ',
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            },
        },
    ],
});

const User = mongoose.model('User', userSchema);
module.exports = User;
