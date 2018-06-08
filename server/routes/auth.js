const router = require('express').Router();
const getUserProfile = require('../middleware/userProfileHandler');
const { CustomError } = require('../middleware/errorHandler');
const asyncHandler = require('express-async-handler');
/**
 * a route that will authenticate user identity and issue a new jwt token in header
 * the authentication will be done by checking whether bangumi can verify user identity
 * with the provided access token
 */
router.post('/auth/token', asyncHandler(getUserProfile), (req, res, next) => {
  req.auth = {
    user_id: req.bangumin.userProfile.user_id,
  };

  if (req.auth.user_id === undefined) return next(new CustomError('user_not_exist', 'Cannot find user from bangumi database'));

  return next();
});

module.exports = router;
