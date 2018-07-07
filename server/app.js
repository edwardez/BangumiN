const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const csrf = require('csurf');
const helmet = require('helmet');
const config = require('./config');
const expressSession = require('express-session');
const MongoStore = require('connect-mongo')(expressSession);
const mongoose = require('mongoose');
const passport = require('./middleware/passportHandler');
const logger = require('./utils/logger')(module);
const oauth = require('./routes/oauth');
const auth = require('./routes/auth');

const app = express();
const server = app.listen(config.server.port, config.server.host);


// enable cors
const corsOption = {
  origin: config.frontEndUrl,
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  exposedHeaders: ['Authorization'],
};

app.use(cors(corsOption));


// rest API requirements
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true,
}));
// TODO: enable csrf support before in production
// app.use(csrf({ cookie: false }));

mongoose.connect(config.mongodb.uri, { useNewUrlParser: true });

app.use(expressSession({
  secret: config.passport.secret.session,
  store: new MongoStore({ mongooseConnection: mongoose.connection }),
  name: 'sessionId',
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    name: 'sessionId',
    maxAge: 31536000000,
    secure: config.cookieSecure,
  },
}));

// security setup
app.use(helmet());

app.use(passport.initialize());
app.use(passport.session());

app.use('/oauth', oauth);
app.use('/auth', passport.authenticationMiddleware(), auth);


// define error-handling middleware last, after other app.use() & routes calls;
const logErrors = function logErrors(err, req, res, next) {
  logger.error('%o', err.stack);
  next(err);
};


// error handler, send stacktrace only during development
// eslint-disable-next-line no-unused-vars
const generalErrorHandler = function errorHandler(err, req, res, next) {
  res
    .status(res.statusCode === 200 ? 500 : res.statusCode)
    .json({ error: err.code === undefined ? 'unclassified' : err.code, error_description: err.message });
};

app.use(logErrors);
app.use(generalErrorHandler);

module.exports = server;

