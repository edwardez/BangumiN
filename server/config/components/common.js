const joi = require('joi');

const envVarsSchema = joi.object({
  NODE_ENV: joi.string()
    .allow(['development', 'production', 'test'])
    .required(),
  FRONT_END_URL: joi.string()
    .uri()
    .required(),
  COOKIE_SECURE: joi.boolean().required(),
  COOKIE_EXPIRE_IN: joi.number().integer().min(1).required(),
}).unknown()
  .required();

const { error, value: envVars } = joi.validate(process.env, envVarsSchema);
if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

const config = {
  env: envVars.NODE_ENV,
  frontEndUrl: envVars.FRONT_END_URL,
  cookieSecure: envVars.SECURE_COOKIE,
  cookieExpireIn: envVars.COOKIE_EXPIRE_IN,
};

module.exports = config;
