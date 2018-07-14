export const environment = {
  production: false,
  environmentType: 'dev',
  displayBuildVersion: false,
  FRONTEND_URL: 'http://127.0.0.1:4200',
  BANGUMI_API_URL: 'http://127.0.0.1:8081/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: 'http://127.0.0.1:8081/proxy/oauth/bangumi',
  BACKEND_API_URL: 'http://127.0.0.1:8081/api',
  BACKEND_AUTH_URL: 'http://127.0.0.1:8081/auth',
  BACKEND_OAUTH_URL: 'http://127.0.0.1:8081/oauth',
  BANGUMI_APP_ID: 'bgm2535b10d2c3d3e8d',
  whitelistedDomains: ['127.0.0.1:8081'],
  blacklistedRoutes: ['127.0.0.1:8081/api', '127.0.0.1:8081/oauth', '127.0.0.1:8081/auth'],
  availableLanguage: {
    'en-US': 'English',
    'zh-Hans': '简体中文'
  },
  commentMaxLength: 200,
  tagsMaxNumber: 10,
  progressPageMaxEpisodeCountMobile: 5,
  progressPageMaxEpisodeCountDesktop: 30,
  invalidEpisode: '-1',
  invalidVolume: '-1'
};
