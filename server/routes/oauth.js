const router = require('express').Router();
const passport = require('passport');
const csrf = require('csurf');
const config = require('../config');

router.get(
  '/bangumi',
  passport.authenticate('bangumi-oauth'),
);

router.get(
  '/bangumi/callback',
  passport.authenticate('bangumi-oauth', {
    failureRedirect: '/',
    session: false,
  }),
  (req, res) => {
    res.cookie('activationInfo', JSON.stringify(req.user), { domain: process.env.HOST})
    res.redirect(`${config.frontEndUrl}/activate?type=bangumi`);
  },
);

const csrfProtection = csrf({ cookie: true });
router.get('/json', csrfProtection, (req, res) => {
  res.json({ csrfToken: req.csrfToken() });
});


module.exports = router;
