import * as express from 'express';
import {findUserByNickname} from '../services/bangumi/userService';
import {User} from '../models/relational/bangumi/user';

const router = express.Router();

// root url: /api/search

// maximum  number of offset, user cannot query beyond this number
const MAX_OFFSET_NUMBER = 200;
/**
 * search user name with keyword
 * only the first MAX_OFFSET_NUMBER results will be returned
 * currently limit parameter is ignored
 */
router.get('/user/:nickname', (req: any, res: any, next: any) => {
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

      return res.json({
        request: req.originalUrl,
        code: 404,
        error: 'Not Found',
      });
    },
  );

});

export default router;
