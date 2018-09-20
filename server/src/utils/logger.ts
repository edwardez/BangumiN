import config from '../config';
import winston from 'winston';

const winstonCloudWatch = require('winston-cloudwatch');
const {combine, timestamp, splat, label, printf} = winston.format;

// for some reason winston will escape new line in formatter, convert then to new line again here
const loggerMessageFormat = printf(info => `${info.timestamp} ${info.level}: ${info.message.split('\\n').join('\n')}`);

const unhandledExceptionsHandler = new winstonCloudWatch({
  logGroupName: `BangumiN-${config.env}`,
  logStreamName: 'unhandledExceptions',
  awsRegion: config.region.default,
  accessKeyId: config.credentials.accessKeyID,
  secretAccessKey: config.credentials.secretAccessKey,
});

const consoleTransport = new winston.transports.Console({
  format: combine(
    winston.format.colorize({all: true}),
    splat(),
    timestamp(),
    loggerMessageFormat,
  ),
});

export const logger = winston.createLogger({
  format: combine(
    splat(),
    timestamp(),
    loggerMessageFormat,
  ),
  level: config.logger.level,
  transports: [
    consoleTransport,
    new winstonCloudWatch({
      logGroupName: `BangumiN-${config.env}`,
      logStreamName: 'regularLogger',
      awsRegion: config.region.default,
      accessKeyId: config.credentials.accessKeyID,
      secretAccessKey: config.credentials.secretAccessKey,
    }),
  ],
  exceptionHandlers: [unhandledExceptionsHandler, consoleTransport],
});
