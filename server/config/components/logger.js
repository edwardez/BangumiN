const joi = require('joi');
const winston = require('winston');
const path = require('path');
const fs = require('fs');

const {
  combine, timestamp, splat,
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

winston.configure({
  format: combine(
    winston.format.colorize({ all: true }),
    splat(),
    timestamp(),
    winston.format.simple(),
  ),
  level: config.logger.level,
  transports: [
    //
    // - Write to all logs with level `info` and below to `combined.log`
    // - Write all logs error (and below) to `error.log`.
    // TODO: write log file according to path in .env
    // TODO: improve log conf
    new winston.transports.File({ filename: path.normalize(`${__dirname}/../../logs/error.log`), level: 'error', eol: '\r\n' }),
    new winston.transports.File({ filename: path.normalize(`${__dirname}/../../logs/combined.log`), eol: '\r\n' }),
    new winston.transports.Console({
    }),
  ],
  // exitOnError: true,
});

// winston.exceptions.handle(new winston.transports.File({
// filename: path.normalize(`${__dirname}/../../logs/exceptions.log`), eol: '\r\n' }));


if (!config.logger.enabled) {
  winston.clear(); // Remove all transports
}
module.exports = config;
