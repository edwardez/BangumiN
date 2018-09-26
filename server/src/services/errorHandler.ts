import config from '../config/web';
import {logger} from '../utils/logger';
import {Response} from 'express';
import * as HttpStatus from 'http-status-codes';

/**
 * A customized class to handle error
 */
export class CustomError extends Error {
  public name: string;
  public customizedErrorCode: BanguminErrorCode;
  public customizedErrorMessage: string;
  public originalError: Error;

  /**
   * Initialize a new Error object
   * @param customizedErrorCode see {@link BanguminErrorCode}
   * @param originalError the original error object
   * @param customizedErrorMessage This message will be attached to the response so any sensitive info shouldn't be included
   */
  constructor(customizedErrorCode: BanguminErrorCode, originalError: Error, customizedErrorMessage?: string) {
    super(customizedErrorMessage || originalError.message);
    Object.setPrototypeOf(this, new.target.prototype); // restore prototype chain
    Error.captureStackTrace(this, this.constructor); // after initialize properties
    this.name = originalError.name;
    this.message = originalError.message;
    this.customizedErrorMessage = customizedErrorMessage || '';
    this.customizedErrorCode = customizedErrorCode;
    this.originalError = originalError;
    const messageLines = (this.message.match(/\n/g) || []).length + 1;
    this.stack = `${this.stack.split('\n').slice(0, messageLines + 1).join('\n')}\n${originalError.stack}`;
  }
}

export enum BanguminErrorCode {
  UnclassifiedInternalError = 1,
  ValidationError = 2,
  BangumiServerResponseError = 3,
  RequestResourceNotFoundError = 4,
  RDSResponseError = 5,
  NoSQLResponseError = 6,
  UnauthorizedError = 7,
}

/**
 * Logger an error response, then return a express {@link Response}
 * @param error CustomError object
 * @param response express {@link Response}
 * @param statusCode Http Status Code
 * @param message Message that will be attached to the response
 */
function responseLoggerAndGenerator(error: CustomError, response: Response, statusCode: number, message: string): Response {
  logger.error('%o', error.stack);
  return response.status(statusCode).json({
    message,
    code: error.customizedErrorCode,
  });
}

/**
 * A handler which tries to handle exception and returns more specific error code
 * @param err error object
 * @param req request
 * @param res response
 * @param next next middleware
 */
const specificErrorHandler = function errorHandler(err: any, req: any, res: any, next: any) {
  if (err && !res.headersSent) {
    if (err.name === 'ValidationError' || err.customizedErrorCode === BanguminErrorCode.ValidationError) {
      // if customizedErrorCode is not set, then set it to ValidationError(ValidationError might not come from CustomError)
      err.customizedErrorCode = err.customizedErrorCode || BanguminErrorCode.ValidationError;
      return responseLoggerAndGenerator(err, res, HttpStatus.BAD_REQUEST,
        err.customizedErrorMessage || 'Input is not' +
        ' valid');
    }
    if (err.customizedErrorCode === BanguminErrorCode.UnauthorizedError) {
      return responseLoggerAndGenerator(err, res, HttpStatus.BAD_REQUEST,
        err.customizedErrorMessage || 'UnauthorizedError');
    }
    if (err.customizedErrorCode === BanguminErrorCode.RDSResponseError) {
      return responseLoggerAndGenerator(err, res, HttpStatus.INTERNAL_SERVER_ERROR,
        err.customizedErrorMessage || 'Error occurred during querying database');
    }
    if (err.customizedErrorCode === BanguminErrorCode.RequestResourceNotFoundError) {
      return responseLoggerAndGenerator(err, res, HttpStatus.NOT_FOUND,
        err.customizedErrorMessage || 'Requested resource couldn\'t be found');
    }

    return next(err);
  }

  return next();

};

// general error handler, send detailed error message to response only during development
// eslint-disable-next-line no-unused-vars
const generalErrorHandler = function errorHandler(err: any, req: any, res: any, next: any) {
  logger.error('%o', err.stack);
  if (!res.headersSent) {
    res.status(res.statusCode === 200 ? 500 : res.statusCode).json({
      errors: {
        code: BanguminErrorCode.UnclassifiedInternalError,
        message: config.env === 'dev' ? err.message : 'Internal Error',
      },
    });
  }

};

export {generalErrorHandler, specificErrorHandler};
