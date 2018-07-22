const common = require('./components/common');
const logger = require('./components/logger');
const mongodb = require('./components/mongodb');
const server = require('./components/server');
const passport = require('./components/passport');

module.exports = Object.assign({}, common, logger, mongodb, server, passport);
