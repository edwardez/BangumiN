import * as express from 'express';
import Logger from '../utils/logger';

const router = express.Router();
const logger = Logger(module);

/**
 * a route that will authenticate user identity and issue a new jwt token in header
 * the authentication will be done by checking whether bangumi can verify user identity
 * with the provided access token
 */
router.post('/', (req: any, res: any, next: any) => {
  // TODO: add logic to update and get settings
  logger.info(req.body);
  res.json({});
});

export default router;
