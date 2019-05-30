import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/about/about.dart';
import 'package:munin/widgets/setting/logout/Logout.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithSliverAppBar(
      appBarMainTitle: Text("设置"),
      enableBottomSafeArea: false,
      safeAreaChildPadding:
      const EdgeInsets.only(left: 0, right: 0, top: largeOffset),
      nestedScrollViewBody: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('通用'),
              trailing: Icon(
                AdaptiveIcons.forwardIconData,
                size: smallerIconSize,
              ),
              onTap: () {
                Application.router.navigateTo(
                    context,
                    Routes.generalSettingRoute,
                    transition: TransitionType.native);
              },
            ),
            Divider(),
            ListTile(
              title: Text('主题'),
              trailing: Icon(
                AdaptiveIcons.forwardIconData,
                size: smallerIconSize,
              ),
              onTap: () {
                Application.router.navigateTo(
                    context,
                    Routes.themeSettingRoute,
                    transition: TransitionType.native);
              },
            ),
            Divider(),
            ListTile(
              title: Text('屏蔽'),
              trailing: Icon(
                AdaptiveIcons.forwardIconData,
                size: smallerIconSize,
              ),
              onTap: () {
                Application.router.navigateTo(
                    context,
                    Routes.muteSettingRoute,
                    transition: TransitionType.native);
              },
            ),
            Divider(),
            ListTile(
              title: Text('反馈'),
              onTap: () {
                launch('https://bgm.tv/group/bangumin', forceSafariVC: false,
                    forceWebView: false);
              },
            ),
            Divider(),
            ListTile(
              title: Text('关于'),
              onTap: () {
                showMuninAboutDialog(context);
              },
            ),
            Divider(),
            Logout(),
          ],
        ),
      ),
    );
  }

}
