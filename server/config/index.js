const path = require('path');

if (process.env.NODE_ENV === 'development') {
  require('dotenv').config({ path: path.normalize(`${__dirname}/../.env.dev`) }); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'production') {
  require('dotenv').config({ path: path.normalize(`${__dirname}../.env`) }); // eslint-disable-line global-require
} else if (process.env.NODE_ENV === 'test') {
  require('dotenv').config({ path: path.normalize(`${__dirname}../.env.test`) }); // eslint-disable-line global-require
} else {
  throw new Error('NODE_ENV should be one of the following: ' +
      'development/production/test');
}


let config;
try {
  config = require('./web'); // eslint-disable-line global-require
} catch (ex) {
  if (ex.code === 'MODULE_NOT_FOUND') {
    throw new Error('No config for web');
  }

  throw ex;
}

module.exports = config;
