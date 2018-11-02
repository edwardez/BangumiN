// ==UserScript==
// @name         go/BangumiN
// @namespace    https://bangumin.tv
// @version      0.1
// @description  查看统计与发表剧透，在Bangumi添加前往BangumiN对应页面的链接
// @author       Edward
// @include      /https?:\/\/(bgm\.tv|bangumi\.tv|chii\.in)\/subject\/.*/
// @include      /https?:\/\/(bgm\.tv|bangumi\.tv|chii\.in)\/user\/.*/
// @include      /https?:\/\/(bgm\.tv|bangumi\.tv|chii\.in)\/ep\/.*/
// @include      /https?:\/\/(bgm\.tv|bangumi\.tv|chii\.in)\/(anime|game|real|music|book)\/list\/.*/
// @grant        none
// ==/UserScript==

/* eslint-disable no-undef */

(() => {
  const PageType = Object.freeze({
    Unknown: 1, SubjectMain: 2, SubjectOthers: 3, SubjectEpisode: 4, UserHome: 5, UserCollectionList: 6,
  });

  /**
   * Generate regex that'll be used to match id in url or on page
   * @param pattern {RegExp} Suffix pattern
   * @returns {RegExp} Generated regexp
   */
  function generateRegex(pattern) {
    const BGM_HOST = /https?:\/\/(bgm\.tv|bangumi\.tv|chii\.in)\//;
    return new RegExp(BGM_HOST.source + pattern.source);
  }

  /**
     * Checks urls according to window.location.href then returns page info
     * @returns {Object} PageInfo Object
     */
  function getCurrentPageInfo() {
    const subjectMainPagePattern = window.location.href.match(generateRegex(/subject\/(?:(\d+))$/));
    if (subjectMainPagePattern && subjectMainPagePattern[2]) {
      return {
        pageType: PageType.SubjectMain,
        id: subjectMainPagePattern[2],
      };
    }

    const subjectOthersPattern = window.location.href.match(generateRegex(/subject\/(?:(\d+))\/.+/));
    if (subjectOthersPattern && subjectOthersPattern[2]) {
      return {
        pageType: PageType.SubjectOthers,
        id: subjectOthersPattern[2],
      };
    }

    const episodePattern = window.location.href.match(/ep\/(?:(\w+))\/?/);
    if (episodePattern && episodePattern[2]) {
      const subjectHref = $('#subject_inner_info>a').attr('href');
      const idPatternOnEpsPage = subjectHref ? subjectHref.match(generateRegex(/subject\/(?:(\w+))\/?/)) : null;
      return {
        pageType: PageType.SubjectEpisode,
        id: (idPatternOnEpsPage && idPatternOnEpsPage[2]) ? idPatternOnEpsPage[2] : null,
      };
    }

    const userNamePattern = window.location.href.match(generateRegex(/user\/(?:(\w+))\/?/));
    if (userNamePattern && userNamePattern[2]) {
      return {
        pageType: PageType.UserHome,
        id: userNamePattern[2],
      };
    }

    const collectionListPattern = window.location.href.match(generateRegex(/(anime|game|real|music|book)\/list\/(?:(\w+))\/?/));
    if (collectionListPattern && collectionListPattern[3]) {
      return {
        pageType: PageType.UserCollectionList,
        id: collectionListPattern[3],
      };
    }

    return {
      pageType: PageType.Unknown,
      id: null,
    };
  }
  $(document).ready(() => {
    const BANGUMIN_HOST = 'https://bangumin.tv';

    const pageInfo = getCurrentPageInfo();
    // if data is unknown or invalid, silently quit
    if (pageInfo.pageType === PageType.Unknown || !pageInfo.id) {
      return;
    }
    const navTabs = $('.navTabs');
    const $newSpoilerButton = $(`<br/><a href="${BANGUMIN_HOST}/subject/${pageInfo.id}/spoil" rel="noopener" target="_blank" class="chiiBtn"><span>发表剧透</span>`)
      .css({ 'margin-top': '5px' });

    switch (pageInfo.pageType) {
      case PageType.SubjectMain:
        navTabs.first().append(`<li><a rel="noopener" target="_blank" href="${BANGUMIN_HOST}/subject/${pageInfo.id}/statistics">统计</a></li>`);
        $('#modifyCollect+a').after($newSpoilerButton);
        $('#SecTab').append($newSpoilerButton);
        break;
      case PageType.SubjectOthers:
        navTabs.first().append(`<li><a rel="noopener" target="_blank" href="${BANGUMIN_HOST}/subject/${pageInfo.id}/statistics">统计</a></li>`);
        break;
      case PageType.SubjectEpisode:
        navTabs.first().append(`<li><a rel="noopener" target="_blank" href="${BANGUMIN_HOST}/subject/${pageInfo.id}/statistics">统计</a></li>`);
        break;
      case PageType.UserHome:
        navTabs.first().append(`<li><a rel="noopener" target="_blank" href="${BANGUMIN_HOST}/user/${pageInfo.id}/statistics">统计</a></li>`);
        break;
      case PageType.UserCollectionList:
        navTabs.first().append(`<li><a rel="noopener" target="_blank" href="${BANGUMIN_HOST}/user/${pageInfo.id}/statistics">统计</a></li>`);
        break;
      default:
        break;
    }
  });
})();
