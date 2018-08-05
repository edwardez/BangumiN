import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import helmet from 'helmet';
import config from './config';
import expressSession from 'express-session';
import passport from './middleware/passportHandler';
import authenticationMiddleware from './middleware/authenticationHandler';
import proxy from 'http-proxy-middleware';
import Logger from './utils/logger';
import oauth from './routes/oauth';
import auth from './routes/auth';
import settings from './routes/settings';

const logger = Logger(module);
const dynamoDBStore = require('connect-dynamodb')({session: expressSession});

const app = express();

// if environment is not development, trust the first proxy
if (config.env !== 'development') {
  app.set('trust proxy', 1); // trust first proxy
}

// enable cors
const corsOption = {
  origin: config.frontEndUrl,
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  exposedHeaders: ['Authorization'],
};

app.use(cors(corsOption));

app.use('/proxy/api/bangumi', proxy({
  target: 'https://api.bgm.tv',
  changeOrigin: true,
  pathRewrite: {
    '^/proxy/api/bangumi': '', // rewrite path
  },
  logProvider: () => logger,
}));

app.use('/proxy/oauth/bangumi', proxy({
  target: 'https://bgm.tv',
  changeOrigin: true,
  pathRewrite: {
    '^/proxy/oauth/bangumi': '/oauth', // rewrite path
  },
  logProvider: () => logger,
}));

// rest API requirements
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true,
}));
// TODO: enable csrf support before in production
// app.use(csrf({ cookie: false }));

const dynamoDBStoreOptios = {
  table: `BangumiN_${config.env}_sessions`,
  AWSConfigJSON: {
    accessKeyId: config.dynamodb.accessKeyID,
    secretAccessKey: config.dynamodb.secretAccessKey,
    region: config.dynamodb.region,
  },
};

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
    secure: config.cookieSecure,
  },
}));

// security setup
app.use(helmet());

app.use(passport.initialize());
app.use(passport.session());

app.use('/oauth', oauth);
app.use('/api/user/:id/settings', authenticationMiddleware.isAuthenticated, settings);
app.use('/auth', authenticationMiddleware.isAuthenticated, auth);
app.all('*', (req, res) => {
  res.status(404).json({error_code: 'not_found'});
});

// define error-handling middleware last, after other app.use() & routes calls;
const logErrors = function logErrors(err: any, req: any, res: any, next: any) {
  logger.error('%o', err.stack);
  next(err);
};

// error handler, send stacktrace only during development
// eslint-disable-next-line no-unused-vars
const generalErrorHandler = function errorHandler(err: any, req: any, res: any, next: any) {
  res.status(res.statusCode === 200 ? 500 : res.statusCode).json({
    error: err.code === undefined ? 'unclassified' : err.code,
    error_description: err.message,
  });
};

app.use(logErrors);
app.use(generalErrorHandler);

const server = app.listen(config.server.port, config.server.host);

logger.info(`Server running at ${config.server.host}:${config.server.port}`);

export default server;
