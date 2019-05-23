import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/general/PreferredLaunchNavTab.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:redux/redux.dart';

import 'UserProfileWidget.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (Store<AppState> store) =>
      store.state.currentAuthenticatedUserBasicInfo.username,
      distinct: true,
      builder: (BuildContext context, String username) {
        return UserProfileWidget(
          username: username,
          appBar: OneMuninBar(
            title: Text(
              PreferredLaunchNavTab.HomePage.generalSettingPageChineseName,
            ),
          ),
        );
      },
    );
  }
}
