const express = require('express');
const router = express.Router();
const auth = require('../../Middleware/Auth');
const Users = require('../../Modals/user');
const { check, validationResult } = require('express-validator');
const PostController = require('../../Controllers/PostController');

//private route
//POST create post
router.post(
  '/createpost',
  [
    auth,
    check('title', 'title is required').not().isEmpty(),
    check('description', 'Description is required').not().isEmpty(),
  ],
  PostController.CreatePost
);

//DELETE post
//Private route

router.delete('/deletepost/:id', auth, PostController.DeletePost);

module.exports = router;
