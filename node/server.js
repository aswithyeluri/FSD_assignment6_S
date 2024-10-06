const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files from the ecomm-main directory
app.use(express.static(path.join(__dirname, '..')));

// Serve registration page
app.get('/register', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'signup.html')); // Serve the signup page
});

// Serve login page
app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'login.html')); // Serve the login page
});

// Registration route
app.post('/register', (req, res) => {
    console.log(req.body); 

    const { username, email, password } = req.body;

    // Check for empty fields
    if (!username || !email || !password) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    // Read existing users from users.json
    const usersFilePath = path.join(__dirname, 'users.json');
    let users = [];

    // Initialize users if the file doesn't exist
    if (fs.existsSync(usersFilePath)) {
        users = JSON.parse(fs.readFileSync(usersFilePath, 'utf8'));
        console.log("Existing users:", users); // Log existing users for debugging
    }

    // Check if user already exists
    const userExists = users.some(user => user.email === email);
    if (userExists) {
        return res.status(400).json({ message: 'User already exists' });
    }

    // Add new user to the array
    users.push({ username, email, password });

    // Save the updated users array to users.json
    fs.writeFileSync(usersFilePath, JSON.stringify(users, null, 2));

    res.json({ message: 'Registration successful' });
});


// // Login route with redirect to profile page
// app.post('/login', (req, res) => {
//     const { email, password } = req.body;
//     const usersFilePath = path.join(__dirname, 'users.json');
//     const users = JSON.parse(fs.readFileSync(usersFilePath, 'utf8'));
//     const user = users.find(u => u.email === email && u.password === password);

//     if (user) {
//         res.redirect('/profile');  // Redirect to profile page on success
//     } else {
//         res.status(401).send('Incorrect email or password');
//     }
// });

// Login route
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    const usersFilePath = path.join(__dirname, 'users.json');
    const users = JSON.parse(fs.readFileSync(usersFilePath, 'utf8'));
    const user = users.find(u => u.email === email && u.password === password);

    if (user) {
        res.json({ message: 'Login successful' });  // Respond with success
    } else {
        res.status(401).json({ message: 'Incorrect email or password' });
    }
});


app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});