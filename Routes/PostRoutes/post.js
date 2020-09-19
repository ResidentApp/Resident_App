const express = require('express');
const router = express.Router();
const auth = require('../../Middleware/Auth');
const Users = require('../../Modals/user');
const Posts = require('../../Modals/post');
const { check, validationResult } = require('express-validator');

//private route
//POST create post
router.post(
  '/createpost',
  [
    auth,
    check('title', 'title is required').not().isEmpty(),
    check('description', 'Description is required').not().isEmpty(),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty) {
      return res.status(400).json({ errors: errors.array() });
    }
    try {
      const newPost = new Posts({
        title: req.body.title,
        description: req.body.description,
        author: req.user.id,
        imgURL: req.body.imgURL,
        tags: req.body.tags,
        location: req.body.location,
      });
      const post = await newPost.save();
      res.json(post);
    } catch (err) {
      console.error(err.message);
      res.status(500).send('server Error');
    }
  }
);

module.exports = router;
