import config from '../config';
import dynamoose from 'dynamoose';
import * as Joi from 'joi';
import Logger from '../utils/logger';

const logger = Logger(module);

export interface UserSchema {
  id: string;
  loggedInAt: number;
  appLanguage?: string;
  bangumiLanguage?: string;
}

export interface UserModel extends dynamoose.Model<UserModel>, UserSchema {
}

const userSchema = new dynamoose.Schema({
  id: {
    hashKey: true,
    lowercase: true,
    required: true,
    type: String,
    trim: true,
    validate: (v: string) => Joi.string().regex(/^[0-9]+$/).validate(v).error === null,
  },
  appLanguage: {
    default: 'zh-Hans',
    type: String,
    trim: true,
    validate: (v: string) => {
      return Joi.string().valid(['en-US', 'zh-Hans']).validate(v).error === null;
    },
  },
  bangumiLanguage: {
    default: 'original',
    type: String,
    trim: true,
    validate: (v: string) => {
      return Joi.string().valid(['original', 'zh-Hans']).validate(v).error === null;
    },
  },
  loggedInAt: {
    default: (new Date).getTime(),
    type: Number,
    trim: true,
    validate: (v: number) => {
      return Joi.date().timestamp().validate(v).error === null;
    },
  },

}, {
  timestamps: true,
});

export const userModel = dynamoose.model(`BangumiN_${config.env}_users`, userSchema);

export class User {

  private userModel: UserModel;

  constructor(userModel: UserModel) {
    this.userModel = userModel;
  }

  /**
   * create a new user, return error upon rejection
   * @param id user primary key id
   * @param appLanguage app main language
   */
  static createUser(id: string, appLanguage?: string): Promise<dynamoose.Model<UserModel>> {
    logger.info(`Create new user: ${id}`);

    const userData = appLanguage === undefined ? {id: id.toString()} : {id: id.toString(), appLanguage: appLanguage.toString()};
    const newUser = new userModel(userData);
    return newUser.save().catch((error) => {
      logger.error(`Cannot save user: ${id}`);
      logger.error(error);
      return error;
    });
  }

  /**
   * find user settings and return, if user doesn't exist, create user and return a new user model as a promise
   * @param userID user id, can be string or number, number will be converted to string
   */
  static findOrCreateUser(userID: string | number): Promise<dynamoose.Model<UserModel>> {
    const id = userID.toString();
    return userModel.get(id).then((existedUser: UserModel) => {
      if (existedUser === undefined) {
        logger.info(`User: ${id} is not in database`);
        return User.createUser(id);
      }
      logger.info(`Bangumi user:${id}, database id:${existedUser.id} logged in`);
      return existedUser;
    }).catch((error) => {
      logger.error(`Failed to execute find user step for id:${id}`);
      logger.error(error.stack);
      return error;
    });
  }

  /**
   * Update user settings
   * @param userSettings user settings
   */
  static updateUser(userSettings: UserSchema): Promise<dynamoose.Model<UserModel>> {
    const userId = userSettings.id.toString();
    delete userSettings.id;
    logger.info('Trying to update user %s\'s settings as %o', userId, userSettings);
    // id shouldn't be updated, exclude it
    return userModel.update({id: userId}, userSettings).then((updatedUser) => {
      logger.info('Succeeded to update user settings');
      return updatedUser;
    }).catch((error) => {
      logger.error('Failed to update user settings');
      logger.error(error.stack);
      return error;
    });
  }

}
