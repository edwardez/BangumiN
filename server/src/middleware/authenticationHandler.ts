/**
 * check whether user is authenticated or not, if not
 * send a 401 unauthorized response
 * @returns {Function}
 */
export function authenticationMiddleware() {
  return (req: any, res: any, next: any) => {
    if (req.isAuthenticated()) {
      return next();
    }
    return res.sendStatus(401);
  };
}
