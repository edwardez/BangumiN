const router = require('express').Router();
const passport = require('passport');
const logger = require('../utils/logger')(module);
const csrf = require('csurf');
const config = require('../config');
const jwt = require('jsonwebtoken');
const expressJwt = require('express-jwt');
const getUserProfile = require('../middleware/userProfileHandler');
const {CustomError} = require('../middleware/errorHandler');
const asyncHandler = require('express-async-handler');

// generate a jwt token
const createToken = function createToken(auth) {
    return jwt.sign(
        {
            user_id: auth.user_id,
        }, config.passport.secret.jwt,
        {
            expiresIn: '5 days',
        },
    );
};

// retrieve id from req.auth and pass it to createToken()
const generateToken = function generateToken(req, res, next) {
    req.token = createToken(req.auth);
    next();
};

// send jwt auth token in header back to client
const sendToken = function sendToken(req, res, next) {
    res.header('Authorization', `Bearer ${req.token}`);
    res.status(200).json(req.auth);
    next();
};

// authenticate user using jwt token
const authenticate = expressJwt({
    secret: config.passport.secret.jwt,
    requestProperty: 'auth',
    getToken(req) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            return req.headers.authorization.split(' ')[1];
        }
        return null;
    },
});

/**
 * a route that will authenticate user identity and issue a new jwt token in header
 * the authentication will be done by checking whether bangumi can verify user identity
 * with the provided access token
 */
router.post('/jwt/token/', asyncHandler(getUserProfile), (req, res, next) => {
    req.auth = {
        user_id: req.bangumin.userProfile.user_id,
    };

    if (req.auth.user_id === undefined) return next(new CustomError('user_not_exist', 'Cannot find user from bangumi database'));

    return next();
}, generateToken, sendToken);


module.exports = router;
