export const environment = {
  production: true,
  FRONTEND_URL: 'https://bangumin.tv',
  BANGUMI_API_URL: '/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: '/proxy/oauth/bangumi',
  BACKEND_API_URL: 'https://bangumin.tv/api',
  BACKEND_AUTH_URL: 'https://bangumin.tv/auth',
  BACKEND_OAUTH_URL: 'https://bangumin.tv/oauth',
  BANGUMI_APP_ID: 'bgm1065aa2020942ce2',
  whitelistedDomains: ['proxy.bangumin.tv'],
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
