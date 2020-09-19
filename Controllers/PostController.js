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
    res.status(500).send('server error');
  }
};

exports.DeletePost = async (req, res) => {
  try {
    const post = await Posts.findById(req.params.id);
    //check if post exists
    if (!post) {
      return res.status(404).send({ msg: 'post not found' });
    }
    //check if the post belongs to user or not

    if (post.author.toString() != req.user.id) {
      return res.status(401).json({ msg: 'User not Authorized' });
    }
    await post.remove();
    res.json('Post removed');
  } catch (err) {
    console.error(err.message);
    if (err.kind === 'ObjectId') {
      return res.status(404).json({ msg: 'post not found' });
    }
    res.status(500).send('Server error');
  }
};
