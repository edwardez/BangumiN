import * as express from 'express';
import Logger from '../../utils/logger';
import {findSubjectById} from '../../services/bangumi/subjectService';

const router = express.Router();
const logger = Logger(module);

// root url: /api/bangumi/subject
/**
 * get  multiple subjects info
 */
router.get('/:subjectId', (req: any, res: any, next: any) => {
  const subjectId = req.params.subjectId;

  findSubjectById(subjectId).then(
    (subject) => {
      if (subject) {
        return res.json(subject.toJSON());
      }

      return res.json({
        request: req.originalUrl.replace(/^\/api\/bgm/, ''),
        code: 404,
        error: 'Not Found',
      });
    },
  );

  // return res.json(userId);
});

export default router;
