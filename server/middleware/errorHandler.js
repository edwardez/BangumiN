const logger = require('winston');
const router = require('express').Router();

const logErrors = function logErrors(err, req, res, next) {
  logger.error('%s', err.stack);
  next(err);
};


// error handler, send stacktrace only during development
const generalErrorHandler = function errorHandler(err, req, res) {
  res
    .status(err.status ? err.status : 500)
    .json({
      error: process.env.NODE_ENV === 'development' ? err : {},
    });
  res.render('internal error');
};

router.use(logErrors);
router.use(generalErrorHandler);

module.exports = router;
