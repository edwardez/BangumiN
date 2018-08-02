import * as express from 'express';
import getUserProfile from '../middleware/userProfileHandler';
import {CustomError} from '../middleware/errorHandler';
import asyncHandler from 'express-async-handler';

const router = express.Router();

/**
 * a route that will authenticate user identity and issue a new jwt token in header
 * the authentication will be done by checking whether bangumi can verify user identity
 * with the provided access token
 */
router.post('/token', asyncHandler(getUserProfile), (req: any, res: any, next: any) => {
  req.auth = {
    user_id: req.bangumin.userProfile.user_id,
  };

  if (req.auth.user_id === undefined) return next(new CustomError('user_not_exist', 'Cannot find user from bangumi database'));

  return next();
});

export default router;
