import joi from 'joi';

const envVarsSchema = joi.object({
  AWS_ACCESS_KEY_ID: joi.string()
    .required(),
  AWS_SECRET_ACCESS_KEY: joi.string()
    .required(),
  AWS_REGION: joi.string()
    .required(),
}).unknown()
  .required();

const {error, value: envVars} = joi.validate(process.env, envVarsSchema);
if (error) {
  throw new Error(`Con fig validation error: ${error.message}`);
}

const config = {
  dynamodb: {
    accessKeyID: envVars.AWS_ACCESS_KEY_ID,
    secretAccessKey: envVars.AWS_SECRET_ACCESS_KEY,
    region: envVars.AWS_REGION,
  },
};

export default config;
