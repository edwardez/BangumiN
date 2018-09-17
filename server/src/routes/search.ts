import * as express from 'express';

import Logger from '../utils/logger';
import {findUserByNickname} from '../services/bangumi/userService';
import {User} from '../models/relational/bangumi/user';

const router = express.Router();
const logger = Logger(module);

// root url: /api/search

/**
 * search user name with keyword
 */
router.get('/user/:nickname', (req: any, res: any, next: any) => {
  const nickname = req.params.nickname;
  const fullMatch = req.query.fullMatch === 'true';
  const offset = Number(req.query.offset || 0);

  findUserByNickname(nickname, fullMatch, true, offset).then(
    (user: { rows: User[], count: number }) => {
      if (user) {
        return res.json({
          fullMatch,
          ...user,
        });
      }

      return res.json({
        request: req.originalUrl,
        code: 404,
        error: 'Not Found',
      });
    },
  );

});

export default router;
