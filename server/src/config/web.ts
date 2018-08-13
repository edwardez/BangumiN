import common from './components/common';
import logger from './components/logger';
import aws from './components/aws';
import server from './components/server';
import passport from './components/passport';

const config = Object.assign({}, common, logger, aws, server, passport);
export default config;
