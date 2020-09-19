const express = require('express');
const router = express.Router();
const auth = require('../../Middleware/auth');
const Users = require('../../Modals/user');

//test route

router.get('/', auth, async (req, res) => {
  try {
    const user = await Users.findById(req.user.id).select('-password');
    res.json(user);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});

module.exports = router;
