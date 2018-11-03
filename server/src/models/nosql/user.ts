import config from '../../config/index';
import dynamoose from 'dynamoose';
import * as Joi from 'joi';
import {logger} from '../../utils/logger';
import {BanguminErrorCode, CustomError} from '../../services/errorHandler';

export interface UserSchema {
  id: string;
  appLanguage?: string;
  bangumiLanguage?: string;
  appTheme?: string;
  showA11YViolationTheme?: boolean;
  stopCrawling?: boolean;
  loggedInAt?: number;
  updatedAt?: number;
  createdAt?: number;
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
  appTheme: {
    default: 'bangumin-material-blue-teal',
    type: String,
    trim: true,
    validate: (v: string) => {
      return Joi.string().valid(['bangumin-material-blue-teal',
        'bangumin-material-dark-pink-blue-grey', 'bangumi-pink-blue']).validate(v).error === null;
    },
  },
  showA11YViolationTheme: {
    default: false,
    type: Boolean,
    trim: true,
    validate: (v: boolean) => {
      return Joi.boolean().validate(v).error === null;
    },
  },
  stopCrawling: {
    default: false,
    type: Boolean,
    trim: true,
    validate: (v: boolean) => {
      return Joi.boolean().validate(v).error === null;
    },
  },
  loggedInAt: {
    default: new Date(),
    type: Date,
    trim: true,
    validate: (v: number) => {
      return Joi.date().timestamp().validate(v).error === null;
    },
  },

}, {
  timestamps: true,
  saveUnknown: false,
});

export const userModel = dynamoose.model(`BangumiN_${config.env}_users`, userSchema);

export class User {

  private userModel: UserModel;

  constructor(userModel: UserModel) {
    this.userModel = userModel;
  }

  /**
   * find user settings and return
   * @param userID user id, can be string or number, number will be converted to string
   * @param hiddenFields list of fields that shouldn't be returned, i.e. user password
   */
  static findUser(userID: string | number, hiddenFields: string[] = []): Promise<dynamoose.Model<UserModel>> {
    if (!userID) {
      throw new CustomError(BanguminErrorCode.ValidationError, new Error(BanguminErrorCode[BanguminErrorCode.ValidationError]),
        'Expect userID to be a' +
        ' truthy value');
    }

    const id = userID.toString();
    return userModel.get(id)
      .then((existedUser: UserModel) => {
        return existedUser ? <UserModel>User.deleteProtectedFields(existedUser, hiddenFields) : existedUser;
      })
      .catch((error) => {
        logger.error(`Failed to execute find user step for id:${id}`);
        throw error;
      });
  }

  /**
   * create a new user, throw error upon rejection
   * @param userInstance user settings
   */
  static createUser(userInstance: UserSchema): Promise<dynamoose.Model<UserModel>> {
    if (!userInstance || !userInstance.id) {
      throw new CustomError(BanguminErrorCode.ValidationError, new Error(BanguminErrorCode[BanguminErrorCode.ValidationError]),
        'Expect userInstance and userInstance.id to be a truthy value');
    }

    logger.info(`Create new user: ${userInstance.id}`);

    const newUser = new userModel({...userInstance, ...{id: userInstance.id.toString()}});
    return newUser.save()
      .then((savedUser: UserModel) => {
        logger.info(`Successfully created user: ${savedUser.id}`);
        return savedUser;
      })
      .catch((error) => {
        logger.error(`Cannot save user: ${userInstance.id}`);
        throw error;
      });
  }

  /**
   * login, then find user settings and return, if user doesn't exist, create user and return a new user model as a promise
   * @param userID user id, can be string or number, number will be converted to string
   */
  static logInOrSignUpUser(userID: string | number): Promise<dynamoose.Model<UserModel>> {
    if (!userID) {
      throw new CustomError(BanguminErrorCode.ValidationError, new Error(BanguminErrorCode[BanguminErrorCode.ValidationError]),
        'Expect userID to be a truthy value');
    }

    const id = userID.toString();
    return User.findUser(id)
      .then((existedUser: UserModel) => {
        if (existedUser === undefined) {
          logger.info(`User: ${id} is not in database`);
          return User.createUser({id});
        }
        logger.info(`Bangumi user:${id}, database id:${existedUser.id} logged in`);
        return existedUser;
      })
      .catch((error) => {
        throw error;
      })
      ;
  }

  /**
   * Update user settings
   * @param userSettings user settings
   * @param protectedSettings a list of settings that shouldn't be updated by default
   */
  static updateUser(userSettings: UserSchema, protectedSettings = ['loggedInAt', 'updatedAt', 'createdAt'])
    : Promise<dynamoose.Model<UserModel>> {
    if (!userSettings || !userSettings.id) {
      throw new CustomError(BanguminErrorCode.ValidationError, new Error(BanguminErrorCode[BanguminErrorCode.ValidationError]),
        'Expect userSettings and userSettings.id to be a truthy value');
    }

    const copiedUserSettings = User.deleteProtectedFields(userSettings, protectedSettings);
    copiedUserSettings.id = copiedUserSettings.id.toString(); // in case a number is passed in
    logger.info('Trying to update user %s\'s settings as %o', copiedUserSettings.id, copiedUserSettings);
    // id shouldn't be updated, exclude it
    return userModel.update({id: copiedUserSettings.id.toString()}, copiedUserSettings)
      .then((updatedUser) => {
        logger.info('Succeeded to update user settings as %o', userSettings);
        return updatedUser;
      }).catch((error) => {
        logger.error('Failed to update user settings as %o', userSettings);
        throw error;
      });
  }

  /**
   * delete protected user settings in case they shouldn't be directly updated or retried:
   * this method is a in-place modification
   * i.e. user can update settings, but they shouldn't be able to manually update their loggedInAt timestamp
   * or, user can request a copy of their settings, but they shouldn't be able to retrieve their password
   * @param userInstance user settings
   * @param fieldsToDelete a list of settings that shouldn't be updated, default to loggedInAt, updatedAt, createdAt, note: dynamoose
   *   may still update updatedAt, createdAt and it's out of our control
   * @return a  modified user settings copy
   */
  static deleteProtectedFields(userInstance: UserSchema | UserModel, fieldsToDelete = ['loggedInAt', 'updatedAt', 'createdAt']):
    UserSchema | UserModel {
    if (!userInstance || !userInstance.id) {
      throw new CustomError(BanguminErrorCode.ValidationError, new Error(BanguminErrorCode[BanguminErrorCode.ValidationError]),
        'Expect userInstance and userInstance.id to be a truthy value');
    }
    fieldsToDelete.forEach(Reflect.deleteProperty.bind(null, userInstance));
    return userInstance;
  }

}
