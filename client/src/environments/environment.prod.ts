export const environment = {
  production: true,
  BANGUMI_API_URL: '/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: '/proxy/oauth/bangumi',
  BACKEND_API_URL: 'https://bangumin.tv/api',
  BACKEND_AUTH_URL: 'https://bangumin.tv/auth',
  BACKEND_OAUTH_REDIRECT_URL: 'https://bangumin.tv/oauth',
  whitelistedDomains: ['bangumin.tv'],
  blacklistedRoutes: [/http:\/\/localhost:3000\/proxy\/.+/g, /https?:\/\/bangumin\.tv\/auth.+/g],
};
