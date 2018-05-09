/**
 * a custom error handler
 * @param code a short description of the error, e.g. user_not_found
 * @param message a longer description of the error(and possible solution, if
 * it can be handled by the client, e.g. try to login again with a valid account)
 * @constructor
 */
function CustomError(code, message) {
  Error.captureStackTrace(this, this.constructor);
  this.name = this.constructor.name;
  this.message = message;
  this.code = code;
}

module.exports = {
  CustomError,
};
