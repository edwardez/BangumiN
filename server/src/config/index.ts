const path = require('path');

if (process.env.NODE_ENV === 'development') {
  require('dotenv').config({path: path.normalize(`${__dirname}/../../.env.dev`)}); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'production') {
  require('dotenv').config({path: path.normalize(`${__dirname}/../../.env`)}); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'test') {
  require('dotenv').config({path: path.normalize(`${__dirname}/../../.env.test`)}); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'uat') {
  require('dotenv').config({path: path.normalize(`${__dirname}/../../.env.uat`)}); // eslint-disable-line global-require
} else {
  throw new Error('NODE_ENV should be one of the following: ' +
    'development/production/uat/test');
}

import config from './web';

export default config;
