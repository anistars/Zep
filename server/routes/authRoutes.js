const express = require('express');
const router = express.Router();
const authControlrs = require('../controllers/authControlrs');
router.post('/signup', authControlrs.signup_post);
router.post('/login', authControlrs.login_post);
router.post('/payment', authControlrs.single_post);
module.exports = router;
