const router = require('express').Router();
const passport = require('passport');
const logger = require('winston');
const config = require('../config/components/passport');


router.get(
  '/bangumi',
  passport.authenticate('bangumi-oauth'),
);


router.get(
  '/bangumi/callback',
  passport.authenticate('bangumi-oauth', {
    failureRedirect: '/failed',
    session: true,
  }),
  (req, res, next) => {
    if (!req.user) {
      return res.send(401, 'User Not Authenticated');
    }
    logger.debug(req.user);

    // Successful authentication, redirect home.
    req.auth = {
      id: req.user.user_id,
    };

    return next();
  },
);


router.get('/me', passport.authenticationMiddleware(), (req, res) => {
  logger.debug(req.user);
  logger.debug(res);
});


module.exports = router;
