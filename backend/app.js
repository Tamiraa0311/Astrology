const express = require('express');
const User = require('./User');  // Adjust the path if needed
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const cors = require('cors');
const app = express();
const port = 3000;

// MongoDB connection URI
const mongoURI = 'mongodb+srv://Shinee:1234@cluster0.ycpln.mongodb.net/Astrology?retryWrites=true&w=majority';

// Connect to MongoDB
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Connected to MongoDB'))
    .catch(err => console.error('Could not connect to MongoDB', err));

// Define a schema for planets
const planetSchema = new mongoose.Schema({
    id: Number,
    name: String,
    image: String,
    description: String
});
app.get('/api/username', async (req, res) => {
    try {
        const user = await User.findOne({ username: req.query.name });
// Fetch the first user from the database
        if (user) {
            res.json({ username: user.name });
        } else {
            res.status(404).json({ message: "User not found" });
        }
    } catch (err) {
        console.error('Error occurred:', err);
        res.status(500).json({ message: "Server error" });
    }
});


// Create model using the schema
const Planet = mongoose.model('Planet', planetSchema, 'day');  // Use 'day' collection

app.use(cors()); // Enable CORS
app.use(express.json()); // Enable JSON parsing


  
app.post('/login', async (req, res) => {
    const { phone, password } = req.body;
  
    if (!phone || !password) {
      return res.status(400).json({ message: 'Phone and password are required' });
    }
  
    try {
      // Find the user by phone number
      const user = await User.findOne({ phone });
      if (!user) {
        return res.status(400).json({ message: 'User not found' });
      }
  
      // Compare the hashed password with the provided password
      const isMatch = await bcrypt.compare(password, user.password);
  
      if (!isMatch) {
        return res.status(400).json({ message: 'Invalid credentials' });
      }
  
      // If login is successful
      res.status(200).json({ message: 'Login successful', user });
    } catch (err) {
      console.error('Error during login:', err);
      res.status(500).json({ error: 'Server error' });
    }
  });

// GET endpoint to fetch planets
app.get('/planets', async (req, res) => {
    try {
        // Fetch planets from the 'day' collection
        const planets = await Planet.find().select('name image description');  // Adjusting selection
        console.log('Fetched planets:', planets);  // Log the data to check

        // If no planets are found, return a 404 message
        if (planets.length === 0) {
            return res.status(404).json({ message: 'No planets found' });
        }

        // Send the fetched planets as the response
        res.json(planets);
    } catch (err) {
        console.error('Error fetching planets:', err);
        res.status(500).json({ error: 'Database query failed' });
    }
});

app.post('/signup', async (req, res) => {
    const { name, phone, birthDate, password, gender } = req.body;

    // Validate data
    if (!name || !phone || !birthDate || !password || !gender) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    try {
        // Check if the user already exists
        const existingUser = await User.findOne({ phone });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Hash the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create a new user with gender
        const newUser = new User({
            name,
            phone,
            birthDate,
            password: hashedPassword,
            gender
        });

        // Save the user to the database
        await newUser.save();

        // Send success response
        res.status(201).json({ message: 'User registered successfully', user: newUser });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server running on http://192.168.1.10:${port}`);
});
