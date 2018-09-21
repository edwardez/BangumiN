import * as express from 'express';
import {findUserByIdOrUserName} from '../../services/bangumi/userService';
import {User} from '../../models/relational/bangumi/user';
import {celebrate, Joi} from 'celebrate';
import {BanguminErrorCode, CustomizedError} from '../../services/errorHandler';

const router = express.Router();

// root url: /api/bangumi/user

/**
 * get user info
 */
router.get('/:userId', celebrate({
  params: {
    userId: Joi.string().alphanum(),
  },
}), (req: any, res: any, next: any) => {
  const userId = req.params.userId;

  findUserByIdOrUserName(userId).then(
    (user: User) => {
      if (user) {
        return res.json(user.toJSON());
      }

      return res.json({
        request: req.originalUrl.replace(/^\/api\/bgm/, ''),
        code: 404,
        error: 'Not Found',
      });
    },
  ).catch((error) => {
    throw new CustomizedError(BanguminErrorCode.RDSResponseError, error);
  });

});

export const user = router;
