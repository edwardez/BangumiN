import * as express from 'express';
import asyncHandler from 'express-async-handler';
import passport from 'passport';
import config from '../config';
import joi from 'joi';
import {logger} from '../utils/logger';
import requestPromise from 'request-promise';
import authenticationMiddleware from '../services/authenticationHandler';
import {BanguminErrorCode, CustomError} from '../services/errorHandler';

const router = express.Router();

/**
 * verify bangumi user refresh token request is in the correct format
 * @param req request context
 * @param res response context
 * @returns accessToken access token of the account
 */
function verifyBangumiUserRefreshAccessTokenRequest(req: any, res: any) {
  const tokenSchema = joi.object({
    refreshToken: joi.string().required(),
    clientId: joi.string()
      .valid(config.passport.oauth.bangumi.clientID)
      .required(),
    grantType: joi.string().valid('refresh_token').required(),
    redirectUrl: joi.string()
      .valid(config.passport.oauth.bangumi.callbackURL)
      .required(),
    userId: [joi.string().valid(req.user.id.toString()).required(), joi.number().valid(Number(req.user.id)).required()],
  }).unknown().required();

  const {error, value: tokenVars} = joi.validate(req.body, tokenSchema);
  if (error) {
    throw new CustomError(BanguminErrorCode.ValidationError, error);
  }

  const {refreshToken} = tokenVars;

  return refreshToken;
}

/**
 * refresh user access token by using refresh token to get new token set at
 * bangumi server
 * @param req request
 * @param res response
 * @param next next middleware
 * @returns {Promise<*>}
 */
export const refreshUserAccessToken = async function refreshUserAccessToken(req: any, res: any, next: any) {
  let refreshToken;
  try {
    refreshToken = verifyBangumiUserRefreshAccessTokenRequest(req, res);
  } catch (error) {
    logger.error('Request cannot be verified: %o', req.body);
    if (error instanceof CustomError || error.name === 'ValidationError') {
      return next(error);
    }
    return next(new CustomError(BanguminErrorCode.ValidationError, error));
  }

  const options = {
    method: 'POST',
    json: true,
    uri: `${config.passport.oauth.bangumi.tokenURL}`,
    body: {
      grant_type: 'refresh_token',
      client_id: config.passport.oauth.bangumi.clientID,
      client_secret: config.passport.oauth.bangumi.clientSecret,
      refresh_token: refreshToken,
      redirect_uri: config.passport.oauth.bangumi.callbackURL,
    },
  };
  let response;

  try {
    response = await requestPromise(options);
    req.refreshedTokenInfo = response;
  } catch (error) {
    logger.error('Response cannot be parsed or verified: %o', response);
    if (error instanceof CustomError || error.name === 'ValidationError') {
      return next(error);
    }
    return next(new CustomError(BanguminErrorCode.BangumiServerResponseError, error));
  }

  return next();
};

router.get(
  '/bangumi',
  passport.authenticate('bangumi-oauth'),
);

router.get(
  '/bangumi/callback', (req: any, res, next) => {
    return passport.authenticate('bangumi-oauth', {
      failureRedirect: `${config.frontEndUrl}/activate?type=bangumi&result=failure`,
      session: true,
    }, (error, user, info) => {
      if (error) {
        logger.error('Error occurred during authentication of user %o: %o', user, error);
        return res.redirect(`${config.frontEndUrl}/activate?type=bangumi&result=failure`);
      }

      return req.login(user, (loginError: any) => {
        if (loginError) {
          logger.error('loginError occurred during authentication of user %o: %o', user, loginError);
          return res.redirect(`${config.frontEndUrl}/activate?type=bangumi&result=failure`);
        }
        return next();
      });
    })(req, res, next);
  },

  (req: any, res: any) => {
    res.cookie('userInfo', JSON.stringify(req.user), {
      domain: (config.cookieDomain === '127.0.0.1' ? '' : '.') +
        config.cookieDomain,
    });
    res.cookie('userInfo', JSON.stringify(req.user), {
      domain: (config.cookieDomain === '127.0.0.1' ? '' : '.') +
        config.cookieDomain,
    });
    res.redirect(`${config.frontEndUrl}/activate?type=bangumi&result=success`);
  },
);

router.post(
  '/bangumi/refresh',
  (req, res, next) => {
    return authenticationMiddleware.isAuthenticated(req, res, next);
  },
  asyncHandler(refreshUserAccessToken),
  (req: any, res: any) => res.json(req.refreshedTokenInfo),
);

export const oauth = router;
