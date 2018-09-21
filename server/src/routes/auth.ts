import * as express from 'express';

const router = express.Router();

router.get('/csrf/token', (req: any, res: any, next: any) => {
  // generate csrf token
  res.send({csrfToken: req.csrfToken()});
});

export const auth = router;
