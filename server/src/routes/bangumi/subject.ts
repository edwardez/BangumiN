import * as express from 'express';
import {findSubjectById} from '../../services/bangumi/subjectService';
import {celebrate, Joi} from 'celebrate';
import {BanguminErrorCode, CustomError} from '../../services/errorHandler';

const router = express.Router();

// root url: /api/bangumi/subject
/**
 * get  multiple subjects info
 */
router.get('/:subjectId',
  celebrate({
    params: {
      subjectId: Joi.number().min(0).max(Number.MAX_SAFE_INTEGER),
    },
    query: {
      responseGroup: Joi.string().valid(['base', 'small', 'medium', 'large']),
    },
  }), (req: any, res: any, next: any) => {
    const subjectId = req.params.subjectId;
    const responseGroup = req.query.responseGroup || 'small';
    let exclude: string[];
    if (responseGroup === 'medium' || responseGroup === 'large') {
      exclude = [];
    }

    findSubjectById(subjectId, exclude).then(
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
    ).catch((error) => {
      if (error instanceof CustomError || error.name === 'ValidationError') {
        throw new error;
      }
      throw new CustomError(BanguminErrorCode.RDSResponseError, error);
    });

  });

export const subject = router;
