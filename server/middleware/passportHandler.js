const passport = require('passport');
const OAuth2Strategy = require('passport-oauth2').Strategy;
const config = require('../config/components/passport');
const request = require('request');
const requestPromise = require('request-promise');
const logger = require('../utils/logger')(module);
const joi = require('joi');

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

/**
 * verify that profile is valid
 * profile is returned from server, and it must:
 * have a valid access_token, and client_id should be the same as what's recorded
 * and user_id cannot be empty
 * in .env file
 * @param userProfile user profile object
 * @param clientId oauth client id
 * @returns {*}
 */
function verifyAccessToken(userProfile, clientId) {
  const profileSchema = joi.object({
    access_token: joi.string().required(),
    user_id: joi.required(),
    client_id: joi.string().valid(clientId).required(),
  }).unknown().required();

  const { error, value: profileVars } = joi.validate(userProfile, profileSchema);
  if (error) {
    throw new Error(`Config validation error: ${error.message}`);
  }

  return profileVars;
}

passport.use('bangumi-oauth', bangumiOauth);

passport.serializeUser((user, done) => {
  done(null, user);
});

passport.deserializeUser((user, done) => {
  done(null, user);
});


passport.getUserProfile = async function getUserProfile(accessToken) {
  let response;
  let data;

  try {
    response = await requestPromise.post(`${config.passport.oauth.bangumi.tokenStatusURL}?app_id=${config.passport.oauth.bangumi.clientID}2&access_token=${accessToken}`);
    data = verifyAccessToken(JSON.parse(response), config.passport.oauth.bangumi.clientID);
  } catch (err) {
    logger.error('Response cannot be parsed or verified: %o', response);
    logger.error(err);
  }

  return data;
};


module.exports = passport;
