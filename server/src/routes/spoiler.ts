import * as express from 'express';
import * as dynamooseSpoilerModel from '../models/nosql/spoiler';
import authenticationMiddleware from '../services/authenticationHandler';
import {BanguminErrorCode, CustomError} from '../services/errorHandler';
import {celebrate, Joi} from 'celebrate';
import {findUserByIdOrUserName} from '../services/bangumi/userService';
import {User} from '../models/relational/bangumi/user';

const router = express.Router({mergeParams: true});

// root url: /api/user/:id

/**
 * create a new spoiler
 */
router.post('/spoiler', authenticationMiddleware.isAuthenticated, celebrate({
  body: {
    spoilerText: Joi.array(),
    relatedSubjects: Joi.array(),
  },
}), (req: any, res: any, next: any) => {

  const newSpoiler: dynamooseSpoilerModel.SpoilerSchema = req.body;
  newSpoiler.userId = req.user.id;
  dynamooseSpoilerModel.Spoiler.createSpoiler(newSpoiler)
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      if (error instanceof CustomError || error.name === 'ValidationError') {
        return next(error);
      }
      throw new CustomError(BanguminErrorCode.NoSQLResponseError, error, 'Error occurred during querying dynamoDB');
    });

});

/**
 * get a spoiler
 */
router.get('/spoiler/:spoilerId', celebrate({
  params: {
    spoilerId: Joi.number(),
    userId: Joi.string(),
  },
}), (req: any, res: any, next: any) => {
  const userId = req.params.userId;
  const spoilerId = req.params.spoilerId;

  dynamooseSpoilerModel.Spoiler.findSpoiler(spoilerId)
    .then((response) => {

      if (response) {
        return res.json(response);
      }

      return res.status(404).json({
        request: req.originalUrl,
        code: 404,
        error: 'Not Found',
      });
    })
    .catch((error) => {
      if (error instanceof CustomError || error.name === 'ValidationError') {
        return next(error);
      }
      throw new CustomError(BanguminErrorCode.NoSQLResponseError, error, 'Error occurred during querying dynamoDB');
    });

});

/**
 * delete a spoiler
 */
router.delete('/spoiler/:spoilerId', celebrate({
  params: {
    spoilerId: Joi.number(),
    userId: Joi.string(),
  },
}), (req: any, res: any, next: any) => {
  const userId = req.params.userId;
  const spoilerId = req.params.spoilerId;

  dynamooseSpoilerModel.Spoiler.deleteSpoiler(spoilerId, req.user.id)
    .then((response) => {

      return res.status(200).json(response || {});

    })
    .catch((error) => {
      if (error instanceof CustomError || error.name === 'ValidationError') {
        return next(error);
      }
      throw new CustomError(BanguminErrorCode.NoSQLResponseError, error, 'Error occurred during querying dynamoDB');
    });

});

/**
 * get all spoilers for a user
 */
router.get('/spoilers', authenticationMiddleware.isAuthenticated, celebrate({
  params: {
    userId: Joi.string().alphanum(),
  },
  query: {
    createdAtStart: Joi.date(),
    createdAtEnd: Joi.date(),
    limit: Joi.number(),
  },
}), (req: any, res: any, next: any) => {
  const requestUserId: string = String(req.params.userId);
  if (isNaN(Number(requestUserId))) {
    return findUserByIdOrUserName(requestUserId).then(
      (user: User) => {
        if (user) {
          // convert string-based username to userId
          req.params.userId = user.id;
          return next();
        }

        throw new CustomError(BanguminErrorCode.RequestResourceNotFoundError,
          new Error(BanguminErrorCode[BanguminErrorCode.RequestResourceNotFoundError]));

      },
    ).catch((error) => {
      if (error instanceof CustomError || error.name === 'ValidationError') {
        return next(error);
      }
      throw new CustomError(BanguminErrorCode.RDSResponseError, error);
    });
  }

  return next();
}, (req: any, res: any, next: any) => {
  const requestUserId: string = String(req.params.userId);
  const sessionUserID: string = req.user.id;
  const createdAtStart: number = Number(req.query.createdAtStart);
  const createdAtEnd: number = Number(req.query.createdAtEnd);

  // currently, list all spoilers are considered private and only user themself can view all of their spoilers
  if (requestUserId !== sessionUserID) {
    throw new CustomError(BanguminErrorCode.UnauthorizedError, new Error(BanguminErrorCode[BanguminErrorCode.UnauthorizedError]),
      'You\'re not authorized to visit this resource');
  }

  const newSpoiler: dynamooseSpoilerModel.SpoilerSchema = req.body;
  dynamooseSpoilerModel.Spoiler.findSpoilers(requestUserId, createdAtStart, createdAtEnd)
    .then((response) => {
      return res.json({spoilers: response, userId: requestUserId, lastKey: response.lastKey || null});
    })
    .catch((error) => {
      throw new CustomError(BanguminErrorCode.NoSQLResponseError, error, 'Error occurred during querying dynamoDB');
    });

});

export const spoiler = router;
