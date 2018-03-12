const joi = require('joi');

const envVarsSchema = joi.object({
  BANGUMI_AUTHORIZATION_URL: joi.string().trim().uri().required(),
  BANGUMI_TOKEN_URL: joi.string().trim().uri().required(),
  BANGUMI_CLIENT_ID: joi.string().required(),
  BANGUMI_CLIENT_SECRET: joi.string().required(),
  BANGUMI_CALLBACK_URL: joi.string().uri().trim().required(),
  BANGUMI_TOKEN_STATUS: joi.string().uri().trim().required(),
  SESSION_SECRET: joi.string().required(),
}).unknown().required();

const { error, value: envVars } = joi.validate(process.env, envVarsSchema);
if (error) {
  throw new Error(`Config validation error: ${error.message}`);
}

const config = {
  passport: {
    oauth: {
      bangumi: {
        authorizationURL: envVars.BANGUMI_AUTHORIZATION_URL,
        tokenURL: envVars.BANGUMI_TOKEN_URL,
        tokenStatusURL: envVars.BANGUMI_TOKEN_STATUS,
        clientID: envVars.BANGUMI_CLIENT_ID,
        clientSecret: envVars.BANGUMI_CLIENT_SECRET,
        callbackURL: envVars.BANGUMI_CALLBACK_URL,
      },
    },
    secret: {
      session: envVars.SESSION_SECRET,
    },
  },
};

module.exports = config;
