import joi from 'joi';

const envVarsSchema = joi.object({
  AWS_ACCESS_KEY_ID: joi.string()
    .required(),
  AWS_SECRET_ACCESS_KEY: joi.string()
    .required(),
  AWS_REGION: joi.string()
    .required(),
  RDS_USERNAME: joi.string()
    .required(),
  RDS_PASSWORD: joi.string()
    .required(),
  RDS_ADDRESS: joi.string().hostname()
    .required(),
  RDS_DB_NAME: joi.string()
    .required(),
  RDS_PORT: joi.number().positive()
    .required(),
}).unknown()
  .required();

const {error, value: envVars} = joi.validate(process.env, envVarsSchema);
if (error) {
  throw new Error(`Con fig validation error: ${error.message}`);
}

const config = {
  region: {
    default: envVars.AWS_REGION,
  },
  credentials: {
    accessKeyID: envVars.AWS_ACCESS_KEY_ID,
    secretAccessKey: envVars.AWS_SECRET_ACCESS_KEY,
  },
  dynamodb: {
    accessKeyID: envVars.AWS_ACCESS_KEY_ID,
    secretAccessKey: envVars.AWS_SECRET_ACCESS_KEY,
    region: envVars.AWS_REGION,
  },
  rds: {
    address: envVars.RDS_ADDRESS,
    port: envVars.RDS_PORT,
    dbName: envVars.RDS_DB_NAME,
    userName: envVars.RDS_USERNAME,
    password: envVars.RDS_PASSWORD,
  },
};

export default config;
