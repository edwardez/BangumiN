/* tslint:disable */
// modified version to add support for `state`, disable tslint as this is copied from another library and it's a temporary solution
// Type definitions for passport-oauth2 1.4
// Project: https://github.com/jaredhanson/passport-oauth2#readme
// Definitions by: Pasi Eronen <https://github.com/pasieronen>
//                 Wang Zishi <https://github.com/WangZishi>
// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped
// TypeScript Version: 2.3

import {Request} from 'express';
import {Strategy} from 'passport';

declare class OAuth2Strategy extends Strategy {
  constructor(options: OAuth2Strategy.StrategyOptionsWithState, verify: OAuth2Strategy.VerifyFunction);

  authenticate(req: Request, options?: any): void;

  userProfile(accessToken: string, done: (err?: Error | null, profile?: any) => void): void;

  authorizationParams(options: any): object;

  tokenParams(options: any): object;

  parseErrorResponse(body: any, status: number): Error | null;
}

declare namespace OAuth2Strategy {
  type VerifyCallback = (err?: Error | null, user?: object, info?: object) => void;

  type VerifyFunction =
    ((accessToken: string, refreshToken: string, profile: any, verified: VerifyCallback) => void) |
    ((accessToken: string, refreshToken: string, results: any, profile: any, verified: VerifyCallback) => void);
  type VerifyFunctionWithRequest =
    ((req: Request, accessToken: string, refreshToken: string, profile: any, verified: VerifyCallback) => void)
    |
    ((req: Request, accessToken: string, refreshToken: string, results: any, profile: any, verified: VerifyCallback) => void);

  interface _StrategyOptionsBase {
    authorizationURL: string;
    tokenURL: string;
    clientID: string;
    clientSecret: string;
    callbackURL: string;
  }

  interface StrategyOptions extends _StrategyOptionsBase {
    passReqToCallback?: false;
  }

  interface StrategyOptionsWithRequest extends _StrategyOptionsBase {
    passReqToCallback: true;
  }

  interface StrategyOptionsWithState extends _StrategyOptionsBase {
    state: boolean;
  }

  type Strategy = OAuth2Strategy;

  const Strategy: typeof OAuth2Strategy;

  class TokenError extends Error {
    code: string;
    uri?: string;
    status: number;

    constructor(message: string | undefined, code: string, uri?: string, status?: number);
  }

  class AuthorizationError extends Error {
    code: string;
    uri?: string;
    status: number;

    constructor(message: string | undefined, code: string, uri?: string, status?: number);
  }

  class InternalOAuthError extends Error {
    oauthError: any;

    constructor(message: string, err: any);
  }
}

export = OAuth2Strategy;
