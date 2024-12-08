const mongoose = require('mongoose');

// Define the User schema
const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    phone: { type: String, required: true, unique: true },
    birthDate: { type: String, required: true },
    password: { type: String, required: true },
    gender: { type: String, required: true },
});

// Create the User model from the schema
const User = mongoose.model('User', userSchema);

module.exports = User;
