export const environment = {
  production: true,
  environmentType: 'prod',
  displayBuildVersion: false,
  FRONTEND_URL: 'https://bangumin.tv',
  BACKEND_URL: 'https://api.bangumin.tv',
  BANGUMI_API_URL: 'https://api.bangumin.tv/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: 'https://api.bangumin.tv/proxy/oauth/bangumi',
  BACKEND_API_URL: 'https://api.bangumin.tv',
  BACKEND_AUTH_URL: 'https://api.bangumin.tv/auth',
  BACKEND_OAUTH_URL: 'https://api.bangumin.tv/oauth',
  BANGUMI_APP_ID: 'bgm1065aa2020942ce2',
  whitelistedDomains: ['api.bangumin.tv'],
  blacklistedRoutes: ['api.bangumin.tv/oauth', 'api.bangumin.tv/auth'],
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
  googleAnalyticsTrackingId: 'UA-125851644-1'
};
