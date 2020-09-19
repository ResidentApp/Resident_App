const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const locationSchema = new Schema({
    type: {
      type: String,
      default: "Point"
    },
    coordinates: {
      type: [Number],
      index: "2dsphere"
    }
});

const PostSchema = new Schema(
  {
    author: {
      type: Schema.Types.ObjectId,
      ref: 'user',
    },
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    imgURL: {
      type: String,
    },
    location: locationSchema,
    upvotes: [
      {
        user: {
          type: Schema.Types.ObjectId,
          ref: 'user',
        },
      },
    ],
    downvotes: [
      {
        user: {
          type: Schema.Types.ObjectId,
          ref: 'user',
        },
      },
    ],
    flags: [
      {
        user: {
          type: Schema.Types.ObjectId,
          ref: 'user',
        },
      },
    ],
    expiry: {
      type: Boolean,
      default: false,
    },
    tags: [String],
    date: {
      type: Date,
      default: Date.now,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model('post', PostSchema);