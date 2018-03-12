const joi = require('joi');
const winston = require('winston');
const path = require('path');
const fs = require('fs');

const {
  combine, timestamp, printf, splat, json,
} = winston.format;

// create logs folder if it doesn't exist
if (!fs.existsSync('logs')) {
  fs.mkdirSync('logs');
}

const envVarsSchema = joi.object({
  LOGGER_LEVEL: joi.string()
    .allow(['error', 'warn', 'info', 'verbose', 'debug', 'silly'])
    .default('info'),
  LOGGER_ENABLED: joi.boolean()
    .truthy('TRUE')
    .truthy('true')
    .falsy('FALSE')
    .falsy('false')
    .default(true),
}).unknown()
  .required();

const { error, value: envVars } = joi.validate(process.env, envVarsSchema);
if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

const config = {
  logger: {
    level: envVars.LOGGER_LEVEL,
    enabled: envVars.LOGGER_ENABLED,
  },
};


const myFormat = printf(info => `${info.timestamp} ${info.level}: ${info.message}`);

winston.configure({
  format: combine(
    splat(),
    timestamp(),
    myFormat,
    json(),
  ),
  level: config.logger.level,
  transports: [
    //
    // - Write to all logs with level `info` and below to `combined.log`
    // - Write all logs error (and below) to `error.log`.
    // TODO: write log file according to path in .env
    new winston.transports.File({ filename: path.normalize(`${__dirname}/../../logs/error.log`), level: 'error' }),
    new winston.transports.File({ filename: path.normalize(`${__dirname}/../../logs/combined.log`) }),
    new winston.transports.Console({
      prettyPrint(object) {
        return JSON.stringify(object);
      },
      colorize: true,
    }),
  ],
  exitOnError: false,
});

winston.exceptions.handle(new winston.transports.File({ filename: path.normalize(`${__dirname}/../../logs/exceptions.log`) }));

if (!config.logger.enabled) {
  winston.clear(); // Remove all transports
}
module.exports = config;
