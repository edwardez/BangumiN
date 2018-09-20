import * as express from 'express';

import {logger} from '../utils/logger';
import {Record} from '../models/relational/bangumi/record';
import {getSubjectStatsById, getUserStatsByIdOrUsername} from '../services/bangumi/statsService';

const router = express.Router();

/**
 * get user stats info
 */
router.get('/user/:userIdOrUsername', (req: any, res: any, next: any) => {
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

      return res.status(404).json({
        request: req.originalUrl,
        error: 'Not Found',
      });
    },
  ).catch((error) => {
    logger.error('Error while querying user stats %o', error);
    return res.status(500).json({
      request: req.originalUrl,
      code: 500,
      error: 'Error',
    });
  });

});

/**
 * get subject stats info
 */
router.get('/subject/:subjectId', (req: any, res: any, next: any) => {
  const subjectId = Number(req.params.subjectId);

  getSubjectStatsById(subjectId).then(
    (userstats: Record[]) => {
      if (userstats) {
        return res.json({
          subjectId,
          stats: userstats.map(userstat => userstat.toJSON()),
        });
      }

      return res.status(404).json({
        request: req.originalUrl,
        error: 'Not Found',
      });
    },
  ).catch((error) => {
    logger.error('Error while querying subject stats %o', error);
    return res.status(500).json({
      request: req.originalUrl,
      code: 500,
      error: 'Error',
    });
  });

});

export const stats = router;
