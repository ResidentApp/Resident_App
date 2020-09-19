const jwt = require('jsonwebtoken');
const config = require('config');

//Middleware to check the JWT is valid or not

module.exports = function (req, res, next) {
  //get token, we need to feed token from front end again and again
  const token = req.header('x-auth-token'); //set request header as x-auth-token

  if (!token) {
    return res.status(401).json({ msg: 'No token,Authorization denied' });
  }

  //Token Verification
  try {
    const decoded = jwt.verify(token, config.get('jwtSecret'));
    req.user = decoded.user;
    console.log(req.user);
    next();
  } catch (err) {
    res.status(401).json({ msg: 'token is not Valid' });
  }
};
