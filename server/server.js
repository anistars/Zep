const express = require('express');
const mongoose = require("mongoose");
const authRoutes = require('./routes/authRoutes');
var jwt = require('jsonwebtoken');

const app = express()
const port = 5000

app.use(express.json({extended: false}))

//DB
app.get('/', (req, res) => {
    res.send('Hello World!')
})
app.use(authRoutes);
app.listen(port, () => {
    const dbURI = 'mongodb+srv://bidwaigr:test@123@cluster0.d6op1.mongodb.net/auths?retryWrites=true&w=majority';
    mongoose.connect(dbURI, {useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true});
    console.log(`Example app listening at http://localhost:${port}`)
})
