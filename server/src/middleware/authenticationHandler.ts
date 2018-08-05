import {NextFunction, Request, Response} from 'express';

const authenticationMiddleware: any = {};

/**
 * check whether user is authenticated or not, if not
 * send a 401 unauthorized response
 * @returns {Function}
 */
authenticationMiddleware.isAuthenticated = (req: Request, res: Response, next: NextFunction) => {
  if (req.isAuthenticated()) {
    return next();
  }
  return res.sendStatus(401);
};

export default authenticationMiddleware;
