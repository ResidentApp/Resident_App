const express = require('express');
const { check } = require('express-validator');
const UserController = require('../../Controllers/UserController');

const router = express.Router();

router.post(
  '/',
  [
    check('googleID', 'Must include Google ID').not().isEmpty(),
    check('email', 'enter a valid email').isEmail(),
    check('username', 'enter Username').not().isEmpty(),
  ],
  UserController.GoogleSign
);

module.exports = router;
