import * as express from 'express';

import Logger from '../../utils/logger';
import {findSubjectById} from '../../services/bangumi/subjectService';
import {findUserById, findUserByIdOrUserName} from '../../services/bangumi/userService';
import {User} from '../../models/bangumi/user';

const router = express.Router();
const logger = Logger(module);

// root url: /api/bangumi/user

/**
 * get  multiple subjects info
 */
router.get('/:userId', (req: any, res: any, next: any) => {
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
  );

});

export default router;
