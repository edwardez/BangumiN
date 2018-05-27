const joi = require('joi');

const envVarsSchema = joi.object({
  PORT: joi.number()
    .required(),
  HOST: joi.string().hostname(),
}).unknown()
  .required();

const { error, value: envVars } = joi.validate(process.env, envVarsSchema);
if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

const config = {
  server: {
    port: envVars.PORT,
    host: envVars.HOST,
  },
};

module.exports = config;
