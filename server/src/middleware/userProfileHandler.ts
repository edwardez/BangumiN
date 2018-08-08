import {CustomError} from './errorHandler';
import config from '../config/components/passport';
import requestPromise from 'request-promise';
import Logger from '../utils/logger';
import joi from 'joi';

const logger = Logger(module);

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
function verifyAccessToken(userProfile: any, clientId: any) {
  const profileSchema = joi.object({
    access_token: joi.string().required(),
    user_id: joi.required(),
    client_id: joi.string().valid(clientId).required(),
  }).unknown().required();

  const {error, value: profileVars} = joi.validate(userProfile, profileSchema);
  if (error) {
    throw new Error(`Config validation error: ${error.message}`);
  }

  return profileVars;
}


/**
 * an async method that will get user profile from bangumi oauth api
 * this method will return next(error) if:
 * 1. json cannot be parsed
 * 2. verifyAccessToken throws error
 * 3. any other errors that might be caught
 * @param req
 * @param res
 * @param next
 * @returns {Promise<*>}
 */
export default async function getUserProfile(req: any, res: any, next: any) {
  const {accessToken} = req.body;
  req.bangumin = req.bangumin || {};
  let response;
  let userProfile;

  try {
    response = await requestPromise.post(`${config.passport.oauth.bangumi.tokenStatusURL}
    ?app_id=${config.passport.oauth.bangumi.clientID}2&access_token=${accessToken}`);
    userProfile = verifyAccessToken(JSON.parse(response), config.passport.oauth.bangumi.clientID);
    req.bangumin.userProfile = userProfile;
  } catch (err) {
    logger.error('Response cannot be parsed or verified: %o', response);
    logger.error(err);
    return next(new CustomError('response_invalid', 'Response cannot be verified: use your bangumi account to log in again.'));
  }

  return next();
}
