const Users = require('../Modals/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const config = require('config');
const { validationResult } = require('express-validator');

exports.SignUp = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { name, username, email, password } = req.body;
  try {
    //See if user exists
    let user = await Users.findOne({ email });
    //if user exits
    if (user) {
      return res
        .status(400)
        .json({ errors: [{ message: 'User already exists' }] });
    }
    //If user doesn't exists
    user = new Users({
      name,
      username,
      email,
      password,
    });

    //password encryption
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(password, salt);
    await user.save();

    //after saving lets return JWT
    const payload = {
      user: {
        id: user.id,
      },
    };
    jwt.sign(
      payload,
      process.env.jwtSecret,
      {
        expiresIn: 1209600,
      },
      (err, token) => {
        if (err) {
          throw err;
        } else {
          console.log('user signed in ');
          res.json({ token });
        }
      }
    );
  } catch (err) {
    console.log(err.message);
    res.status(500).send('Server error');
  }
};

exports.SignIn = async (req, res) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  const { email, password } = req.body;
  try {
    let user = await Users.findOne({ email });
    if (!user) {
      return res.status(400).json({ errors: [{ msg: 'Invalid Credentials' }] });
    }
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ errors: [{ msg: 'Invalid Credentials' }] });
    }
    const payload = {
      user: {
        id: user.id,
      },
    };
    jwt.sign(
      payload,
      process.env.jwtSecret,
      {
        expiresIn: 1209600,
      },
      (err, token) => {
        if (err) {
          throw err;
        } else {
          console.log('user logged in ');
          res.json({ token });
        }
      }
    );
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
};

exports.GoogleSign = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty) {
    return res.status(400).json({ errors: errors.array() });
  }
  const { email, username, googleID } = req.body;

  try {
    var user = await Users.findOne({ googleID });
    if (user) {
      const payload = {
        user: {
          id: user.id,
        },
      };
      jwt.sign(
        payload,
        process.env.jwtSecret,
        {
          expiresIn: 1209600,
        },
        (err, token) => {
          if (err) {
            throw err;
          } else {
            console.log('user logged in using google ');
            res.json({ token });
          }
        }
      );
    } else {
      user = new Users({
        name: username,
        username: username,
        email: email,
        googleID: googleID,
      });
      await user.save();
      const payload = {
        user: {
          id: user.id,
        },
      };
      jwt.sign(
        payload,
        process.env.jwtSecret,
        {
          expiresIn: 1209600,
        },
        (err, token) => {
          if (err) {
            throw err;
          } else {
            console.log('User signed up using Google');
            res.json({ token });
          }
        }
      );
    }
  } catch (err) {
    console.log(err.message);
    res.status(500).send('Server error');
  }
};
