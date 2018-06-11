export const environment = {
  production: true,
  FRONTEND_URL: 'https://bangumin.tv',
  BANGUMI_API_URL: '/proxy/api/bangumi',
  BANGUMI_OAUTH_URL: '/proxy/oauth/bangumi',
  BACKEND_API_URL: 'https://bangumin.tv/api',
  BACKEND_AUTH_URL: 'https://bangumin.tv/auth',
  BACKEND_OAUTH_URL: 'https://bangumin.tv/oauth',
  BANGUMI_APP_ID: 'bgm1065aa2020942ce2',
  whitelistedDomains: ['bangumin.tv'],
  blacklistedRoutes: [/http:\/\/localhost:3000\/proxy\/.+/g, /https?:\/\/bangumin\.tv\/auth.+/g],
  availableLanguage: {
    'en-US': 'English',
    'zh-Hans': '简体中文'
  },
  commentMaxLength: 200,
  tagsMaxNumber: 10,
  progressPageMaxEpisodeCount: 30,
};
