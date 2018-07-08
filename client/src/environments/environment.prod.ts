export const environment = {
  production: true,
  FRONTEND_URL: 'https://bangumin.tv',
  BANGUMI_API_URL: 'https://api.bangumin.tv/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: 'https://api.bangumin.tv/proxy/oauth/bangumi',
  BACKEND_API_URL: 'https://api.bangumin.tv',
  BACKEND_AUTH_URL: 'https://api.bangumin.tv/auth',
  BACKEND_OAUTH_URL: 'https://api.bangumin.tv/oauth',
  BANGUMI_APP_ID: 'bgm1065aa2020942ce2',
  whitelistedDomains: ['api.bangumin.tv'],
  blacklistedRoutes: ['api.bangumin.tv/oauth', 'api.bangumin.tv/auth'],
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
