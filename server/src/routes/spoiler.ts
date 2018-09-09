import * as express from 'express';
import * as dynamooseSpoilerModel from '../models/spoiler';
import Logger from '../utils/logger';
import authenticationMiddleware from '../services/authenticationHandler';

const router = express.Router();
const logger = Logger(module);

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
      res.json(response);
    })
    .catch((error) => {
      res.status(500);
    });

});

/**
 * get all spoilers for a user
 */
router.get('/spoilers', authenticationMiddleware.isAuthenticated, (req: any, res: any, next: any) => {
  const requestUserId = req.params.userId;
  const sessionUserID = req.user.id;

  // currently, list all spoilers are considered private and only user themself can view all of their spoilers
  if (requestUserId !== sessionUserID) {
    res.status(500);
  }

  const newSpoiler: dynamooseSpoilerModel.SpoilerSchema = req.body;
  dynamooseSpoilerModel.Spoiler.createSpoiler(newSpoiler)
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(500);
    });

});

export default router;
