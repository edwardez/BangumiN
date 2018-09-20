import * as express from 'express';
import * as dynamooseSpoilerModel from '../models/nosql/spoiler';
import authenticationMiddleware from '../services/authenticationHandler';

const router = express.Router({mergeParams: true});

// root url: /api/user/:id

/**
 * create a new spoiler
 */
router.post('/spoiler', authenticationMiddleware.isAuthenticated, (req: any, res: any, next: any) => {

  const newSpoiler: dynamooseSpoilerModel.SpoilerSchema = req.body;
  newSpoiler.userId = req.user.id;
  dynamooseSpoilerModel.Spoiler.createSpoiler(newSpoiler)
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(500);
    });

});

/**
 * get a spoiler
 */
router.get('/spoiler/:spoilerId', (req: any, res: any, next: any) => {
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
      return res.status(500);
    });

});

/**
 * delete a spoiler
 */
router.delete('/spoiler/:spoilerId', (req: any, res: any, next: any) => {
  const userId = req.params.userId;
  const spoilerId = req.params.spoilerId;

  dynamooseSpoilerModel.Spoiler.deleteSpoiler(spoilerId, req.user.id)
    .then((response) => {

      return res.status(200).json(response || {});

    })
    .catch((error) => {
      return res.status(500).json({});
    });

});

/**
 * get all spoilers for a user
 */
router.get('/spoilers', authenticationMiddleware.isAuthenticated, (req: any, res: any, next: any) => {
  const requestUserId = req.params.userId;
  const sessionUserID = req.user.id;
  const createdAtStart: number = Number(req.query.createdAtStart);
  const createdAtEnd: number = Number(req.query.createdAtEnd);

  // currently, list all spoilers are considered private and only user themself can view all of their spoilers
  if (requestUserId !== sessionUserID) {
    return res.status(500).json({});
  }

  const newSpoiler: dynamooseSpoilerModel.SpoilerSchema = req.body;
  dynamooseSpoilerModel.Spoiler.findSpoilers(requestUserId, createdAtStart, createdAtEnd)
    .then((response) => {
      return res.json({spoilers : response, userId: requestUserId, lastKey: response.lastKey || null});
    })
    .catch((error) => {
      return res.status(500).json({});
    });

});

export const spoiler = router;
