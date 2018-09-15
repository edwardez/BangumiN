import * as express from 'express';
import * as dynamooseUserModel from '../models/nosql/user';
import Logger from '../utils/logger';

const router = express.Router();
const logger = Logger(module);

/**
 * post updated user settings to database
 */
router.post('/', (req: any, res: any, next: any) => {
  const id = req.user.id;
  const newUserSettings: dynamooseUserModel.UserSchema = req.body;
  // users are only allowed to update their own settings
  newUserSettings.id = req.user.id;
  dynamooseUserModel.User
    .updateUser(newUserSettings)
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(500);
    });

});

/**
 * get updated user settings from database
 */
router.get('/', (req: any, res: any, next: any) => {
  // users are only allowed to view their own settings, use id from session
  dynamooseUserModel.User
    .findUser(req.user.id)
    .then((response) => {
      res.json(response);
    })
    .catch((error) => {
      res.status(500);
    });

});

export default router;
