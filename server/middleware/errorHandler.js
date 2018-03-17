function CustomError(code, message) {
  Error.captureStackTrace(this, this.constructor);
  this.name = this.constructor.name;
  this.message = message;
  this.code = code;
}

module.exports = {
  CustomError,
};
