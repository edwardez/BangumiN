import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/PreferredLaunchNavTab.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';

import 'UserProfileWidget.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserProfileWidget(
      username: findAppState(context).currentAuthenticatedUserBasicInfo
          .username,
      appBar: OneMuninBar(
        title: Text(
          PreferredLaunchNavTab.HomePage.generalSettingPageChineseName,
          style: Theme
              .of(context)
              .textTheme
              .button,
        ),
        addNotificationWidget: true,
      ),
    );
  }
}
