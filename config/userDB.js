const mongoose = require('mongoose');
const config = require('config');
const db = process.env.URI1;

const connectUserDB = async () => {
  try {
    await mongoose.connect(db, {
      useNewUrlParser: true,
      useCreateIndex: true,
      useUnifiedTopology: true,
    });
    console.log('User database connected');
  } catch (err) {
    console.log(err.message);
    process.exit(1);
  }
};

module.exports = connectUserDB;
