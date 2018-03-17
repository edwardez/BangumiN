const passport = require('passport');
const OAuth2Strategy = require('passport-oauth2').Strategy;
const config = require('../config/components/passport');
const request = require('request');


// oauth strategy for bangumi
const bangumiOauth = new OAuth2Strategy(
  {
    authorizationURL: config.passport.oauth.bangumi.authorizationURL,
    tokenURL: config.passport.oauth.bangumi.tokenURL,
    clientID: config.passport.oauth.bangumi.clientID,
    clientSecret: config.passport.oauth.bangumi.clientSecret,
    callbackURL: config.passport.oauth.bangumi.callbackURL,
    state: true, // set state to true to mitigate CSRF attack
  },
  ((accessToken, refreshToken, profile, done) => done(null, profile)),
);

// implement userProfile function to retrieve user profile from server
// this method avoids DRY, and should be combined with getUserProfile
// ...well, I just want to practice with different ways to make requests
bangumiOauth.userProfile = function userProfile(accessToken, done) {
  // choose your own adventure, or use the Strategy's oauth client
  request.post(
    `${config.passport.oauth.bangumi.tokenStatusURL}?app_id=${config.passport.oauth.bangumi.clientID}2&access_token=${accessToken}`,
    (err, response, body) => {
      if (err) {
        return done(err);
      }
      let data;
      if (!err && response.statusCode === 200) {
        try {
          data = JSON.parse(body);
        } catch (e) {
          return done(e);
        }
      }

      return done(null, data === undefined ? {} : data);
    },
  );
};



passport.use('bangumi-oauth', bangumiOauth);

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((user, done) => {
  done(null, user);
});


module.exports = passport;
