import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import csurf from 'csurf';
import helmet from 'helmet';
import config from './config';
import expressSession from 'express-session';
import passport from './services/passportHandler';
import RateLimit from 'express-rate-limit';
import authenticationMiddleware from './services/authenticationHandler';
import proxy from 'http-proxy-middleware';
import {logger} from './utils/logger';
import {oauth} from './routes/oauth';
import {auth} from './routes/auth';
import {settings} from './routes/settings';
import {spoiler} from './routes/spoiler';
import {sequelize} from './common/sequelize';
import {subject} from './routes/bangumi/subject';
import {user} from './routes/bangumi/user';
import {stats} from './routes/stats';
import {search} from './routes/search';
import {generalErrorHandler, specificErrorHandler} from './services/errorHandler';

const dynamoDBStore = require('connect-dynamodb')({session: expressSession});

const app = express();
// if environment is not development, trust the first proxy
if (config.env !== 'dev') {
  app.set('trust proxy', 1); // trust first proxy
}

// set rate limit
const limiter = new RateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 300, // 300 requests
});

//  apply to all requests
app.use(limiter);

// enable cors
const corsOption = {
  origin: config.frontEndUrl,
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  exposedHeaders: ['Authorization'],
};

app.use(cors(corsOption));

const dynamoDBStoreOptios = {
  table: `BangumiN_${config.env}_sessions`,
  AWSConfigJSON: {
    accessKeyId: config.dynamodb.accessKeyID,
    secretAccessKey: config.dynamodb.secretAccessKey,
    region: config.dynamodb.region,
    readCapacityUnits: config.env === 'prod' ? 30 : 1,
    writeCapacityUnits: config.env === 'prod' ? 30 : 1,
  },
};

sequelize.authenticate()
  .then(
    (res) => {
      logger.info('Successfully connected to rds');
    })
  .catch((error) => {
    logger.error('Cannot connect to database, %o', error);

  });

app.use(expressSession({
  secret: config.passport.secret.session,
  store: new dynamoDBStore(dynamoDBStoreOptios),
  name: 'sessionId',
  resave: false,
  saveUninitialized: false,
  cookie: {
    domain: (config.cookieDomain === '127.0.0.1' ? '' : '.') + config.cookieDomain,
    httpOnly: true,
    maxAge: config.cookieExpireIn,
    secure: 'auto',
  },
}));

// security setup
app.use(helmet());

const csrfProtection = csurf();

app.use(passport.initialize());
app.use(passport.session());

app.use('/proxy/oauth/bangumi', csrfProtection, (req: any, res: any, next: any) => {
  // remove our auth details before sending data to Bangumi
  // TODO: Figure out the best practice to handle this situation
  delete req.headers['x-xsrf-token'];
  delete req.headers['cookie'];
  req.cookie = {};
  req.session.cookie = {};
  return next();
}, proxy({
  target: 'https://bgm.tv',
  changeOrigin: true,
  pathRewrite: {
    '^/proxy/oauth/bangumi': '/oauth', // rewrite path
  },
  logProvider: () => logger,
}));

app.use('/proxy/api/bangumi', csrfProtection, (req: any, res: any, next: any) => {
  delete req.headers['x-xsrf-token'];
  delete req.headers['cookie'];
  req.cookie = {};
  req.session.cookie = {};
  return next();
}, proxy({
  target: 'https://api.bgm.tv',
  changeOrigin: true,
  pathRewrite: {
    '^/proxy/api/bangumi': '', // rewrite path
  },
  logProvider: () => logger,
}));

// create application/json parser
const jsonParser = bodyParser.json();

// create application/x-www-form-urlencoded parser
const urlencodedParser = bodyParser.urlencoded({extended: true});

app.use('/auth', jsonParser, csrfProtection, auth);
app.use('/oauth', jsonParser, csrfProtection, oauth);
app.use('/api/user/:userId', jsonParser, csrfProtection, spoiler);
app.use('/api/user/:userId/setting', jsonParser, csrfProtection, authenticationMiddleware.isAuthenticated, settings);
app.use('/api/stats', jsonParser, csrfProtection, stats);
app.use('/api/search', jsonParser, csrfProtection, authenticationMiddleware.isAuthenticated, search);
app.use('/api/bgm/subject', jsonParser, csrfProtection, subject);
app.use('/api/bgm/user', jsonParser, csrfProtection, user);
app.all('*', jsonParser, (req, res) => {
  res.status(404).json({error_code: 'not_found'});
});

app.use(specificErrorHandler);
app.use(generalErrorHandler);

const server = app.listen(config.server.port, config.server.host);

logger.info(`Server running at ${config.server.host}:${config.server.port}`);

export default server;
