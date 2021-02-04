// const mongoose = require('mongoose')
//
// const userSchema = mongoose.Schema({
//     email: String,
//     password: String,
// }, {timestamps: true});
//
// const User = mongoose.model('user', userSchema);
//
// module.exports = User;




const mongoose = require('mongoose')


const payment = new mongoose.Schema({
    name: String
});

const userSchema = mongoose.Schema({
    email: String,
    password: String,
    children: [ payment ]
}) ;


const User = mongoose.model('user',userSchema);

module.exports = {User};
