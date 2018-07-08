const router = require('express').Router();
const passport = require('passport');
const csrf = require('csurf');
const config = require('../config');
const joi = require('joi');
const logger = require('../utils/logger')(module);
const requestPromise = require('request-promise');
const asyncHandler = require('express-async-handler');

/**
 * verify bangumi user refresh token request is in the correct format
 * @param req request context
 * @returns accessToken access token of the account
 */
function verifyBangumiUserRefreshAccessTokenRequest(req, res) {
  const tokenSchema = joi.object({
    refreshToken: joi.string().required(),
    clientId: joi.string()
      .valid(config.passport.oauth.bangumi.clientID)
      .required(),
    grantType: joi.string().valid('refresh_token').required(),
    redirectUrl: joi.string()
      .valid(config.passport.oauth.bangumi.callbackURL)
      .required(),
    userId: joi.string().valid(req.user.id).required(),
  }).unknown().required();

  const { error, value: tokenVars } = joi.validate(req.body, tokenSchema);
  if (error) {
    logger.error(error);
    logger.error(`Config validation error: ${error.message} for user ${req.user.id}`);
    return res.sendStatus(400);
  }

  const { refreshToken } = tokenVars;

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
const refreshUserAccessToken = async function refreshUserAccessToken(req, res, next) {
  const refreshToken = verifyBangumiUserRefreshAccessTokenRequest(req, res);

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
  } catch (err) {
    logger.error('Response cannot be parsed or verified: %o', response);
    logger.error(err);
    return res.sendStatus(400);
  }

  return next();
};

router.get(
  '/bangumi',
  passport.authenticate('bangumi-oauth'),
);

router.get(
  '/bangumi/callback',
  passport.authenticate('bangumi-oauth', {
    failureRedirect: `${config.frontEndUrl}/activate?type=bangumi&result=failure`,
    session: true,
  }),
  (req, res) => {
    res.cookie('activationInfo', JSON.stringify(req.user), {
      domain: (config.cookieDomain === '127.0.0.1' ? '' : '.') +
      config.cookieDomain,
    });
    res.redirect(`${config.frontEndUrl}/activate?type=bangumi&result=success`);
  },
);

router.post(
  '/bangumi/refresh', passport.authenticationMiddleware(),
  asyncHandler(refreshUserAccessToken),
  (req, res) => res.json(req.refreshedTokenInfo),
);

const csrfProtection = csrf({ cookie: true });
router.get('/json', csrfProtection, (req, res) => {
  res.json({ csrfToken: req.csrfToken() });
});

module.exports = router;
