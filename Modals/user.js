const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const locationSchema = new Schema({
  longitude: {
    type: String,
    required: true,
  },
  latitude: {
    type: String,
    required: true,
  },
});

const UserSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  username: {
    type: String,
    required: true,
  },
  email: {
    type: String,
  },
  password: {
    type: String,
  },
  googleID: String,
  image: {
    type: String,
  },
  location: locationSchema,
  date: {
    type: Date,
    default: Date.now,
  },
});
module.exports = mongoose.model('user', UserSchema);
