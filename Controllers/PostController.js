const { validationResult } = require('express-validator');
const Posts = require('../Modals/post');

exports.CreatePost = async (req, res) => {
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
};
