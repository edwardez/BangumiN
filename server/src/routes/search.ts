import * as express from 'express';
import {findUserByNickname} from '../services/bangumi/userService';
import {User} from '../models/relational/bangumi/user';
import {celebrate, Joi} from 'celebrate';
import {BanguminErrorCode, CustomError} from '../services/errorHandler';

const router = express.Router();

// root url: /api/search

// maximum number of offset, user cannot query beyond this number
const MAX_OFFSET_NUMBER = 200;
/**
 * search user name with keyword
 * only the first MAX_OFFSET_NUMBER results will be returned
 * currently limit parameter is ignored
 */
router.get('/user/:nickname', celebrate({
  params: {
    nickname: Joi.string().required(),
  },
  query: {
    fullMatch: Joi.string().valid(['true', 'false']),
    offset: Joi.string().regex(/^\d+$/),
    limit: Joi.string().regex(/^\d+$/),
  },
}), (req: any, res: any, next: any) => {
  const nickname = req.params.nickname;
  const fullMatch = req.query.fullMatch === 'true';
  const offset = Math.min(Number(req.query.offset || 0), MAX_OFFSET_NUMBER);

  findUserByNickname(nickname, fullMatch, true, offset).then(
    (user: { rows: User[], count: number }) => {
      if (user) {
        return res.json({
          fullMatch,
          ...user,
        });
      }

      throw new CustomError(BanguminErrorCode.RequestResourceNotFoundError,
        new Error(BanguminErrorCode[BanguminErrorCode.RequestResourceNotFoundError]), 'User with specified nickname doesn\'t exist');
    },
  ).catch((error) => {
    if (error instanceof CustomError || error.name === 'ValidationError') {
      throw new error;
    }
    throw new CustomError(BanguminErrorCode.RDSResponseError, error);
  });

});

export const search = router;
