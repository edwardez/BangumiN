import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:redux/redux.dart';

class ImportBlockedBangumiUsersWidget extends StatelessWidget {
  bool enableSubmitButton(
      BuiltMap<String, MutedUser> importedBangumiBlockedUsers) {
    return importedBangumiBlockedUsers != null &&
        importedBangumiBlockedUsers.isNotEmpty;
  }

  List<Widget> _buildListBody(_ViewModel vm) {
    if (vm.importedBangumiBlockedUsers == null) {
      return [AdaptiveProgressIndicator()];
    }

    if (vm.importedBangumiBlockedUsers.isEmpty) {
      return [Text('你没有在Bangumi和任何用户绝交过。')];
    }

    List<Widget> users = [];

    for (MutedUser user in vm.importedBangumiBlockedUsers.values) {
      users.add(ListTile(
        title: Text(user.nickname),
        subtitle: Text('@${user.username}'),
        contentPadding: EdgeInsets.zero,
      ));

      users.add(Divider());
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      onInit: (store) {
        store.dispatch(ImportBlockedBangumiUsersRequestAction());
      },
      onDispose: (store) {
        store.dispatch(ImportBlockedBangumiUsersCleanupAction());
      },
      builder: (BuildContext context, _ViewModel vm) {
        return ScaffoldWithRegularAppBar(
          appBar: AppBar(
            title: Text('导入已绝交用户'),
            actions: <Widget>[
              FlatButton(
                onPressed: enableSubmitButton(vm.importedBangumiBlockedUsers)
                    ? () {
                        vm.confirmImport();
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text('导入'),
              )
            ],
          ),
          safeAreaChild: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
              ),
              ..._buildListBody(vm),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
              ),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '可以导入在',
                        style: Theme.of(context).textTheme.caption),
                    LinkTextSpan(
                        text: 'https://bgm.tv/settings/privacy',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: lightPrimaryDarkAccentColor(context)),
                        url: 'https://bgm.tv/settings/privacy',
                        forceWebView: false,
                        forceSafariVC: false),
                    TextSpan(
                        text: '添加过的已绝交用户。\n',
                        style: Theme.of(context).textTheme.caption),
                  ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final BuiltMap<String, MutedUser> importedBangumiBlockedUsers;
  final void Function() requestImport;
  final void Function() confirmImport;

  factory _ViewModel.fromStore(Store<AppState> store) {
    _requestImport() {
      store.dispatch(ImportBlockedBangumiUsersRequestAction());
    }

    _confirmImport() {
      store.dispatch(ImportBlockedBangumiUsersConfirmAction());
      store.dispatch(PersistAppStateAction(basicAppStateOnly: true));
    }

    return _ViewModel(
      importedBangumiBlockedUsers:
          store.state.settingState.muteSetting.importedBangumiBlockedUsers,
      requestImport: _requestImport,
      confirmImport: _confirmImport,
    );
  }

  _ViewModel({
    @required this.importedBangumiBlockedUsers,
    @required this.requestImport,
    @required this.confirmImport,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          importedBangumiBlockedUsers == other.importedBangumiBlockedUsers;

  @override
  int get hashCode => importedBangumiBlockedUsers.hashCode;
}
