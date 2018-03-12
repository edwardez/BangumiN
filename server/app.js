const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const csrf = require('csurf');
const config = require('./config');
const expressSession = require('express-session');
const passport = require('./middleware/passportHandler');

const auth = require('./routes/auth');

const app = express();

// enable cors
const corsOption = {
  origin: true,
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  exposedHeaders: ['x-auth-token'],
};

app.use(cors(corsOption));

const csrfProtection = csrf({ cookie: true });


// rest API requirements
app.use(bodyParser.urlencoded({
  extended: true,
}));
app.use(bodyParser.json());

app.use(expressSession({
  secret: config.passport.secret.session,
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    domain: config.server,
  },
}));

app.use(passport.initialize());
app.use(passport.session());

app.use('/auth', auth);

// define error-handling middleware last, after other app.use() & routes calls;
require('./middleware/errorHandler');

app.listen(config.server.port, config.server.host);

module.exports = app;
