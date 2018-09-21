import * as express from 'express';
import {Record} from '../models/relational/bangumi/record';
import {getSubjectStatsById, getUserStatsByIdOrUsername} from '../services/bangumi/statsService';
import {celebrate, Joi} from 'celebrate';
import {BanguminErrorCode, CustomizedError} from '../services/errorHandler';

const router = express.Router();

/**
 * get user stats info
 */
router.get('/user/:userIdOrUsername', celebrate({
  params: {
    userIdOrUsername: Joi.string().alphanum(),
  },
}), (req: any, res: any, next: any) => {
  const userIdOrUsername: string | number = isNaN(Number(req.params.userIdOrUsername)) ? req.params.userIdOrUsername : Number(
    req.params.userIdOrUsername);

  getUserStatsByIdOrUsername(userIdOrUsername).then(
    (userstats: Record[]) => {
      if (userstats) {
        return res.json(
          {
            ...(typeof userIdOrUsername === 'number' ? {userId: userIdOrUsername} : {userName: userIdOrUsername}),
            stats: userstats.map(userstat => userstat.toJSON()),
          }
          ,
        );
      }

      throw new CustomizedError(BanguminErrorCode.RequestResourceNotFoundError,
        new Error(BanguminErrorCode[BanguminErrorCode.RequestResourceNotFoundError]), 'Requested user id stats doesn\'t exist');
    },
  ).catch((error) => {
    throw new CustomizedError(BanguminErrorCode.RDSResponseError, error);
  });

});

/**
 * get subject stats info
 */
router.get('/subject/:subjectId', celebrate({
  params: {
    subjectId: Joi.number().min(0).max(Number.MAX_SAFE_INTEGER),
  },
}), (req: any, res: any, next: any) => {
  const subjectId = req.params.subjectId;

  getSubjectStatsById(subjectId).then(
    (userstats: Record[]) => {
      if (userstats) {
        return res.json({
          subjectId,
          stats: userstats.map(userstat => userstat.toJSON()),
        });
      }

      throw new CustomizedError(BanguminErrorCode.RequestResourceNotFoundError,
        new Error(BanguminErrorCode[BanguminErrorCode.RequestResourceNotFoundError]), 'Requested subject id stats doesn\'t exist');
    },
  ).catch((error) => {
    throw new CustomizedError(BanguminErrorCode.RDSResponseError, error);
  });

});

export const stats = router;
