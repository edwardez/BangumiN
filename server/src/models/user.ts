import config from '../config';
import dynamoose from 'dynamoose';
import * as Joi from 'joi';
import Logger from '../utils/logger';

const logger = Logger(module);

export interface IUserModel extends dynamoose.Model<IUserModel> {
  id: string;
  appLanguage?: string;
  bangumiLanguage?: string;
}

const userSchema = new dynamoose.Schema(
  {
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

  },
  {
    timestamps: true,
  });

export const userModel = dynamoose.model(`BangumiN_${config.env}_users`, userSchema);

export class UserModel {

  private userModel: IUserModel;

  constructor(userModel: IUserModel) {
    this.userModel = userModel;
  }

  get id(): string {
    return this.userModel.id;
  }

  static createUser(id: string, appLanguage?: string): Promise<dynamoose.Model<IUserModel>> {
    logger.info(`Create new user: ${id}`);

    const userData = appLanguage === undefined ? {id: id.toString()} : {id: id.toString(), appLanguage: appLanguage.toString()};
    const newUser = new userModel(userData);
    return newUser.save().catch((error) => {
      logger.error(`Cannot save user: ${id}`);
      logger.error(error);
      return error;
    });
  }

  static findOrCreateUser(id: string): Promise<dynamoose.Model<IUserModel>> {
    return userModel.get(id).then((existedUser: IUserModel) => {
        if (existedUser === undefined) {
          logger.info(`User: ${id} is not in database`);
          return UserModel.createUser(id);
        }
        logger.info(`Bangumi user:${id}, database id:${existedUser.id} logged in`);
        return existedUser;
      },
    ).catch((error) => {
      if (error === undefined) {
      }
      logger.error(`Failed to execute find user step for id:${id}`);
      logger.error(error.stack);
      return error;
    });
  }

  static updateUser(userSettings: IUserModel): Promise<dynamoose.Model<IUserModel>> {
    // id cannot be updated, exclude it
    const newUserSettings = Object.assign(userSettings);
    delete newUserSettings.id;
    return userModel.update(userSettings.id, newUserSettings).then(
      (updatedUserSettings) => {
        logger.info('Successfully updated user settings');
        return updatedUserSettings;
      },
    ).catch((error) => {
      return error;
    });
  }

}
