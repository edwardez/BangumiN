import common from './components/common';
import logger from './components/logger';
import mongodb from './components/mongodb';
import server from './components/server';
import passport from './components/passport';

const config = Object.assign({}, common, logger, mongodb, server, passport);
export default config;
