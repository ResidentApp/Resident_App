const express = require('express');
const router = express.Router();
const UserController = require('../../Controllers/UserController');

const { check } = require('express-validator');

router.post(
  '/',
  [
    check('email', 'please enter a valid email').isEmail(),
    check('password', 'Password is required').exists(),
  ],
  UserController.SignIn
);

module.exports = router;
