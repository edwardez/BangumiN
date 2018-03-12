const router = require('express').Router();
const passport = require('passport');
const logger = require('winston');
const csrf = require('csurf');

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
  (req, res) => {
    res.redirect('/');
  },
);

const csrfProtection = csrf({ cookie: true });
router.get('/json', csrfProtection, (req, res) => {
  res.json({ csrfToken: req.csrfToken() });
});


router.post('/json', csrfProtection, (req, res) => {
  res.json({ a: 2 });
});

router.get('/me', passport.authenticationMiddleware(), (req, res) => {
  logger.debug('%o', req.user);
  res.send('success!');
});


module.exports = router;
