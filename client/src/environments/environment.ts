// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
  production: false,
  BANGUMI_API_URL: '/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: '/proxy/oauth/bangumi',
  BACKEND_API_URL: 'http://localhost:3000/api',
  BACKEND_AUTH_URL: 'http://localhost:3000/auth',
  BACKEND_OAUTH_REDIRECT_URL: 'http://localhost:3000/oauth'
};
