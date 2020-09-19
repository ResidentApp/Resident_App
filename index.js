const express = require('express');
const connectUserDB = require('./config/userDB');
const app = express();

//connecting Database
connectUserDB();

//express-parser
app.use(express.json({ extended: false }));

const PORT = process.env.PORT || 5000;

//connect your routes here

//route ends

app.listen(PORT, () => {
  console.log(`server started at port ${PORT}`);
});
