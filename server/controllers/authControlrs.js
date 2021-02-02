const { User } = require('../models/user');
const mongoose = require('mongoose');
var jwt = require('jsonwebtoken');


module.exports.signup_post = async (req, res) => {
    const { email, password, children } = req.body;
    const user = await User.findOne({ email });

    try {
        if (!user) {
            const user = await User.create({ email, password, children });
            console.log(user._id);
            var token = jwt.sign({ id: user._id }, '$ecretKeyHere');
            res.json({ token: token });
        }else{
            console.log( 'Email Already Registerd Exist!');
            res.json({ msg: 'Email Already Registerd Exist!' }); 
        }
    } catch (error) {
        console.log("Something went Wrong");
    }
}
module.exports.login_post = async (req, res) => {
    const { email, password, children } = req.body;
    try {
        const user = await User.findOne({ email });
        if (user) {
            if (user.password == password) {
                console.log(user._id);
                var token = jwt.sign({ id: user._id }, '$ecretKeyHere');
                res.json({ token: token });
            }
            else {
                res.json({ msg: 'Password Is Not Correct' })
            }
        } else {
            res.json({ msg: 'Email Is Not Correct' })
        }
    } catch (err) {
        res.json({ msg: 'Try Again Later' });
    }
}
module.exports.single_post = async (req, res) => {
    const single_payment = await User.findOne({ email: 'test1@gmail.com' });
    try {
        single_payment.children.push({
            name: 'Jodan Sokutou Geri',
        })
        const updated = await single_payment.save()
        res.send('Reseved');
    } catch (err) {
        res.send('Error');
    }
}
