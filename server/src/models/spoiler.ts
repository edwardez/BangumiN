import config from '../config';
import dynamoose from 'dynamoose';
import * as Joi from 'joi';
import Logger from '../utils/logger';

const logger = Logger(module);

const MAX_RELATED_SUBJECT_NUMBER = 2;
const SPOILER_ID_LENGTH = 10;
const MAX_SPOILER_TEXT_LENGTH = 500;
export interface SpoilerTextChunkSchema {
  insert: string;
  attributes?: {
    spoiler: boolean;
  };
}

export interface SpoilerSchema {
  userId: string;
  spoilerId: string;
  spoilerText: SpoilerTextChunkSchema[];
  relatedSubjects: number[];
  updatedAt?: number;
  createdAt?: number;
  creationTime?: number;
}

export interface SpoilerModel extends dynamoose.Model<SpoilerModel>, SpoilerSchema {
}

function generateSpoilerId(numberOfDigit: number): string {
  return (Math.floor(Math.random() * 9 * (Math.pow(10, numberOfDigit - 1))) + Math.pow(10, numberOfDigit - 1)).toString();
}

const spoilerSchema = new dynamoose.Schema({
  spoilerId: {
    hashKey: true,
    // generate a SPOILER_ID_LENGTH digit number
    default: generateSpoilerId(SPOILER_ID_LENGTH),
    required: true,
    type: String,
    trim: true,
    validate: (v: string) => {
      return Joi.string().length(SPOILER_ID_LENGTH).validate(v).error === null;
    },
  },
  userId: {
    required: true,
    type: String,
    trim: true,
    index: {
      global: true,
      rangeKey: 'creationTime',
      name: 'userId-creationTime-index',
      project: true, // ProjectionType: ALL
      throughput: config.env === 'prod' ? 5 : 1,
    },
    validate: (v: string) => Joi.string().regex(/^[0-9]+$/).validate(v).error === null,
  },
  spoilerText: {
    default: [{insert: ''}],
    required: true,
    type: Array,
    trim: true,
    validate: (v: SpoilerTextChunkSchema[]) => {
      const spoilerTextChunkSchema = Joi.object().keys({
        insert: Joi.string().required(),
        attributes:  Joi.object().keys({
          spoiler: Joi.boolean().required(),
        }),
      });
      const spoilerTextSchema = Joi.array().items(spoilerTextChunkSchema);
      // raw spoiler text, which should be shorter than the maximum length
      const spoilerTextRaw = v.map(spoilerTextChunkRaw => String(spoilerTextChunkRaw.insert)).join('');
      return spoilerTextSchema.validate(v).error === null
        && Joi.string().max(MAX_SPOILER_TEXT_LENGTH).validate(spoilerTextRaw).error === null;
    },
  },
  relatedSubjects: {
    default: [],
    required: true,
    type: [Number],
    trim: true,
    validate: (v: number) => {
      return Joi.array().items(Joi.number().integer().min(0)).min(0).max(MAX_RELATED_SUBJECT_NUMBER).validate(v).error === null;
    },
  },
  creationTime: {
    default: +new Date(),
    type: Number,
    trim: true,
    validate: (v: number) => {
      return Joi.date().timestamp().validate(v).error === null;
    },
  },

}, {
  timestamps: true,
  saveUnknown: false,
});

export const spoilerModel = dynamoose.model(`BangumiN_${config.env}_spoilers`, spoilerSchema);

export class Spoiler {

  private spoilerModel: SpoilerModel;

  constructor(spoilerModel: SpoilerModel) {
    this.spoilerModel = spoilerModel;
  }

  /**
   * Find spoiler and return
   * @param spoilerID spoiler id, can be string or number, number will be converted to string
   * @param hiddenFields list of fields that shouldn't be returned
   */
  static findSpoiler(spoilerID: string | number, hiddenFields: string[] = []): Promise<dynamoose.Model<SpoilerModel>> {
    if (!spoilerID) {
      throw Error('Expect spoilerID to be a truthy value');
    }

    const id = spoilerID.toString();
    return spoilerModel.get(id)
      .then((existedSpoiler: SpoilerModel) => {
        return existedSpoiler ? <SpoilerModel>Spoiler.deleteProtectedFields(existedSpoiler, hiddenFields) : existedSpoiler;
      })
      .catch((error) => {
        logger.error(`Failed to execute find spoiler step for id:${id}`);
        logger.error(error.stack);
        throw error;
      });
  }

  /**
   * Create a new spoiler, throw error upon rejection
   * @param spoilerInstance spoilerInstance
   */
  static createSpoiler(spoilerInstance: SpoilerSchema): Promise<dynamoose.Model<SpoilerModel>> {
    if (!spoilerInstance) {
      throw Error('Expect spoilerInstance to be a truthy value');
    }

    spoilerInstance.spoilerId = generateSpoilerId(SPOILER_ID_LENGTH) ;
    spoilerInstance.creationTime = +new Date();

    logger.info(`Create new spoiler: ${spoilerInstance.spoilerId}`);

    // delete fields that shouldn't be created by user
    Spoiler.deleteProtectedFields(spoilerInstance, ['updatedAt', 'createdAt']);

    const newSpoiler = new spoilerModel(spoilerInstance);
    return newSpoiler.save({
      overwrite: false,
    })
      .then((savedSpoiler: SpoilerModel) => {
        logger.info(`Successfully created spoiler: ${savedSpoiler.spoilerId}`);
        return savedSpoiler;
      })
      .catch((error) => {
        logger.error(`Cannot save spoiler: ${spoilerInstance.spoilerId}`);
        logger.error(error.stack);
        throw error;
      });
  }

  /**
   * Delete protected spoiler attributes in case they shouldn't be directly updated or retried:
   * this method is a in-place modification
   * @param spoilerInstance spoiler instance
   * @param fieldsToDelete A list of spoilers that shouldn't be updated, default to updatedAt, createdAt, note: dynamoose
   *   may still update updatedAt, createdAt and it's out of our control
   * @return A modified spoiler copy
   */
  static deleteProtectedFields(spoilerInstance: SpoilerSchema | SpoilerModel, fieldsToDelete = ['updatedAt', 'createdAt']): SpoilerSchema | SpoilerModel {
    if (!spoilerInstance || !spoilerInstance.spoilerId) {
      throw Error('Expect spoilerInstance and spoilerInstance.spoilerId to be a truthy value');
    }
    fieldsToDelete.forEach(Reflect.deleteProperty.bind(null, spoilerInstance));
    return spoilerInstance;
  }

}