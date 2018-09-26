import * as express from 'express';
import config from '../config';

const router = express.Router();

router.get('/csrf/token', (req: any, res: any, next: any) => {
  // generate csrf token
  res.send({csrfToken: req.csrfToken()});
});

router.post('/logout', (req: any, res: any, next: any) => {
  req.logout();
  console.log(res.headers);
  res.redirect(`${config.frontEndUrl}/login`);
});

export const auth = router;
