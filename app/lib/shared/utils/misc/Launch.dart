import 'package:flutter/cupertino.dart';
import 'package:munin/models/bangumi/setting/general/browser/BrowserSetting.dart';
import 'package:munin/models/bangumi/setting/general/browser/LaunchBrowserPreference.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// A helper wrapper of [launch], this reads user preferences in [AppState] and
/// launch browser in inner/external browsers accordingly.
///
/// Note that if something other than a web url is passed in(i.e. mailto, tel,),
/// browser might  not be launched.
launchByPreference(BuildContext context, String url, {popContext = false}) {
  final browserSetting =
      findAppState(context).settingState.generalSetting.browserSetting ??
          BrowserSetting();
  if (browserSetting.launchBrowserPreference ==
      LaunchBrowserPreference.DefaultInApp) {
    launchWithInAppBrowser(context, url, popContext: popContext);
  } else {
    assert(browserSetting.launchBrowserPreference ==
        LaunchBrowserPreference.DefaultExternal);
    launchWithExternalBrowser(context, url, popContext: popContext);
  }
}

/// Launches url with external browser, only works if [url] is a web url.
launchWithExternalBrowser(BuildContext context, String url,
    {popContext = false}) {
  if (popContext) {
    Navigator.pop(context);
  }
  launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    enableJavaScript: true,
    enableDomStorage: true,
  );
}

/// Launches url with in-app browser, only works if [url] is a web url.
launchWithInAppBrowser(BuildContext context, String url, {popContext = false}) {
  if (popContext) {
    Navigator.pop(context);
  }
  launch(
    url,
    forceSafariVC: true,
    forceWebView: true,
    enableJavaScript: true,
    enableDomStorage: true,
  );
}
