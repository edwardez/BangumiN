import dynamoose from 'dynamoose';
import * as Joi from 'joi';

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

}, {
  timestamps: true,
});

export const user = dynamoose.model('BanguminUAT_Test', userSchema);