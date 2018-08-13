export class AppError extends Error {
  public name: string;
  public code: string;

  constructor(code: string, message: string) {
    super(message);
    Object.setPrototypeOf(this, new.target.prototype); // restore prototype chain
    this.name = (this.constructor as any).name;
    this.code = code;
    this.message = message;
    Error.captureStackTrace(this, this.constructor); // after initialize properties
  }
}
