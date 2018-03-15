const router = require('express').Router();
const passport = require('passport');
const logger = require('../utils/logger')(module);
const csrf = require('csurf');
const config = require('../config');
const jwt = require('jsonwebtoken');
const expressJwt = require('express-jwt');
const joi = require('joi');

const createToken = function createToken(auth) {
  return jwt.sign(
    {
      id: auth.id,
    }, config.passport.secret.jwt,
    {
      expiresIn: 60 * 120,
    },
  );
};

const generateToken = function generateToken(req, res, next) {
  req.token = createToken(req.auth);
  next();
};

const sendToken = function sendToken(req, res, next) {
  res.header('x-auth-token', req.token);
  res.status(200).json(req.auth);
  next();
};

const authenticate = expressJwt({
  secret: config.passport.secret.jwt,
  requestProperty: 'auth',
  getToken(req) {
    if (req.headers['x-auth-token']) {
      return req.headers['x-auth-token'];
    }
    return null;
  },
});


router.post('/jwt/token/', (req, res, next) => {
  passport.getUserProfile(req.body.accessToken).then((userProfile) => {
    if (userProfile === undefined) {
      return res.status(401).json({
        error: 'user_not_valid',
        error_description: 'Cannot verify user identity.',
      });
    }


    req.auth = {
      id: userProfile.user_id,
    };
    return next();
  }).catch((error) => {
    logger.error(error);
  });
}, generateToken, sendToken);


module.exports = router;
