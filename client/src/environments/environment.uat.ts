export const environment = {
  production: false,
  environmentType: 'uat',
  displayBuildVersion: true,
  FRONTEND_URL: 'https://dogfood.bangumin.tv',
  BANGUMI_API_URL: 'https://api.dogfood.bangumin.tv/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: 'https://api.dogfood.bangumin.tv/proxy/oauth/bangumi',
  BACKEND_API_URL: 'https://api.dogfood.bangumin.tv',
  BACKEND_AUTH_URL: 'https://api.dogfood.bangumin.tv/auth',
  BACKEND_OAUTH_URL: 'https://api.dogfood.bangumin.tv/oauth',
  BANGUMI_APP_ID: 'bgm1155aa5769e3a21f',
  whitelistedDomains: ['api.dogfood.bangumin.tv'],
  blacklistedRoutes: ['api.dogfood.bangumin.tv/oauth', 'api.dogfood.bangumin.tv/auth'],
  availableLanguages: {
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
