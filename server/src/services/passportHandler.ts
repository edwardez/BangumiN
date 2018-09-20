import passport from 'passport';
import {Strategy as OAuth2Strategy} from 'passport-oauth2';
import config from '../config/components/passport';
import request from 'request';
import * as dynamooseUserModel from '../models/nosql/user';

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

    const userId: string = profile.user_id.toString();
    dynamooseUserModel.User
      .logInOrSignUpUser(userId)
      .then(
        (userSettings) => {
          dynamooseUserModel.User.updateUser({id: userId, loggedInAt: (new Date).getTime()}, []);
          return done(null, {bangumiActivationInfo: profileWithRefreshToken, banguminSettings: userSettings});
        },
      ).catch((error) => {
        return done(error);
      });
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
  done(null, {id: user['bangumiActivationInfo']['user_id'].toString()});
});

passport.deserializeUser((user, done) => {
  done(null, user);
});

export = passport;
