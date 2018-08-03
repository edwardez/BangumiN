import passport from 'passport';
import {Strategy as OAuth2Strategy} from 'passport-oauth2';
import config from '../config/components/passport';
import request from 'request';
import Logger from '../utils/logger';

const logger = Logger(module);

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
  ((accessToken: string, refreshToken: string, profile: any, done: any) => {
    const profileWithRefreshToken = profile;
    profileWithRefreshToken.refresh_token = refreshToken; // refresh token is not included in profile
    return done(null, profileWithRefreshToken);
  }),
);

// implement userProfile function to retrieve user profile from server
// this method avoids DRY, and should be combined with getUserProfile
// ...well, I just want to practice with different ways to make requests
bangumiOauth.userProfile = function userProfile(accessToken: string, done: any) {
  // choose your own adventure, or use the Strategy's oauth client
  request.post(
    `${config.passport.oauth.bangumi.tokenStatusURL}
        ?app_id=${config.passport.oauth.bangumi.clientID}
        &access_token=${accessToken}`.replace(/\s+/g, ''),
    (err: any, response: any, body: any) => {
      if (err || response.statusCode !== 200) {
        return done(err);
      }
      let data;
      try {
        data = JSON.parse(body);
      } catch (e) {
        return done(e);
      }

      return done(null, data === undefined ? {} : data);
    },
  );
};

passport.use('bangumi-oauth', bangumiOauth);

passport.serializeUser((user: any, done) => {
  done(null, {id: user['user_id']});
});

passport.deserializeUser((user, done) => {
  done(null, user);
});

export = passport;
