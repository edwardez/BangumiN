import config from '../config';
import winston from 'winston';
import path from 'path';
import fs from 'fs';

// create logs folder if it doesn't exist
if (!fs.existsSync(`${__dirname}/../../logs`)) {
  fs.mkdirSync(`${__dirname}/../../logs`);
}

const {
  combine, timestamp, splat, label, printf,

} = winston.format;

// for some reason winston will escape new line in formatter, convert then to new line again here
const myFormat = printf(info => `${info.timestamp}  [${info.label}] ${info.level}: ${info.message.split('\\n').join('\n')}`);

// Return the last folder name in the path and the calling
// module's filename.
const getLabel = function getLabel(callingModule: any) {
  const parts = callingModule.filename.split('/');
  return `${parts[parts.length - 2]}/${parts.pop()}`;
};

// eslint-disable-next-line arrow-body-style
export default (callingModule: any) => {
  return winston.createLogger({
    format: combine(
      winston.format.colorize({all: true}),
      label({label: getLabel(callingModule)}),
      splat(),
      timestamp(),
      myFormat,
    ),
    level: config.logger.level,
    transports: [
      new winston.transports.File({
        filename: path.normalize(`${__dirname}/../logs/error.log`),
        level: 'error',
        eol: '\r\n',
      }),
      new winston.transports.File({
        filename: path.normalize(`${__dirname}/../logs/combined.log`),
        eol: '\r\n',
      }),
      new winston.transports.Console({})],
  });
};
