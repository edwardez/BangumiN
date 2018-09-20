export const environment = {
  production: false,
  environmentType: 'dev',
  displayBuildVersion: false,
  FRONTEND_URL: 'http://127.0.0.1:4200',
  BACKEND_URL: 'http://127.0.0.1:8081',
  BANGUMI_API_URL: 'http://127.0.0.1:8081/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: 'http://127.0.0.1:8081/proxy/oauth/bangumi',
  BACKEND_API_URL: 'http://127.0.0.1:8081/api',
  BACKEND_AUTH_URL: 'http://127.0.0.1:8081/auth',
  BACKEND_OAUTH_URL: 'http://127.0.0.1:8081/oauth',
  BANGUMI_APP_ID: 'bgm2535b10d2c3d3e8d',
  whitelistedDomains: ['127.0.0.1:8081'],
  blacklistedRoutes: ['127.0.0.1:8081/api', '127.0.0.1:8081/oauth', '127.0.0.1:8081/auth'],
  availableLanguages: {
    'en-US': 'English',
    'zh-Hans': '简体中文'
  },
  availableAppThemes: [
    'bangumin-material-blue-teal',
    'bangumin-material-dark-pink-blue-grey',
    'bangumi-pink-blue',
  ],
  commentMaxLength: 200,
  tagsMaxNumber: 10,
  progressPageMaxEpisodeCountMobile: 5,
  progressPageMaxEpisodeCountDesktop: 30,
  invalidEpisode: '-1',
  invalidVolume: '-1',
  googleAnalyticsTrackingId: 'UA-125851644-2'
};
