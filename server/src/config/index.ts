const path = require('path');

if (process.env.NODE_ENV === 'dev') {
  require('dotenv').config({path: path.normalize(`${process.cwd()}/.env.dev`)}); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'prod') {
  require('dotenv').config({path: path.normalize(`${process.cwd()}/.env`)}); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'test') {
  require('dotenv').config({path: path.normalize(`${process.cwd()}/.env.test`)}); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'uat') {
  require('dotenv').config({path: path.normalize(`${process.cwd()}/.env.uat`)}); // eslint-disable-line global-require
} else {
  throw new Error('NODE_ENV should be one of the following: ' +
    'dev/prod/uat/test');
}

import config from './web';

export default config;
