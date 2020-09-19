const express = require('express');
const router = express.Router();
const auth = require('../../Middleware/Auth');
const Users = require('../../Modals/user');
const { check, validationResult } = require('express-validator');
const PostController = require('../../Controllers/PostController');

//create post
router.post(
  '/createpost',
  [
    auth,
    check('title', 'title is required').not().isEmpty(),
    check('description', 'Description is required').not().isEmpty(),
  ],
  PostController.CreatePost
);

//delete my post
router.delete('/deletepost/:id', auth, PostController.DeletePost);

//get my posts
router.get('/myposts', auth, PostController.GetMyPosts);

//upvote a post
router.put('/upvote/:id', auth, PostController.Upvote);

//downvote a post
router.put('/downvote/:id', auth, PostController.Downvote);

//flag a post
router.put('/flag/:id', auth, PostController.Flags);

//get post by id
router.get('/:id', auth, PostController.GetPostById);

module.exports = router;
