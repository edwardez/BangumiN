import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:munin/models/bangumi/setting/version/MuninVersionInfo.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/setting/SettingActions.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/shared/utils/misc/Launch.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';

class MuninVersionWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MuninVersionWidgetState();
  }
}

class _MuninVersionWidgetState extends State<MuninVersionWidget> {
  static const defaultDownloadUrl =
      'https://github.com/edwardez/BangumiN/releases';

  final httpClient = Client();
  String latestVersionPrompt;
  bool isLatestVersion = false;

  PackageInfo packageInfo;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((v) => packageInfo = v);
  }

  void setNewestVersion(MuninVersionInfo muninVersion) async {
    if (muninVersion == null) {
      return null;
    }

    try {
      if (packageInfo == null) {
        packageInfo = await PackageInfo.fromPlatform();
      }

      final current = Version.parse(packageInfo.version);
      final latest = Version.parse(muninVersion.latestVersion);
      if (latest.compareTo(current) > 0) {
        latestVersionPrompt = '有新版本 ${muninVersion.latestVersion}';
        isLatestVersion = false;
      } else {
        latestVersionPrompt = '已更新到最新版 ${muninVersion.latestVersion}';
        isLatestVersion = true;
      }
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      }
    } catch (error, stack) {
      reportError(error, stack: stack);
    }
  }

  Widget _buildVersionWidget() {
    if (isLatestVersion) {
      return Text(latestVersionPrompt);
    }

    final theme = Theme.of(context);
    return Text(
      latestVersionPrompt,
      style: theme.textTheme.body1.copyWith(color: theme.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MuninVersionInfo>(
      converter: (store) => store.state.settingState.muninVersionInfo,
      distinct: true,
      onInit: (store) {
        if (store.state.settingState.muninVersionInfo == null) {
          final action = GetLatestMuninVersionRequestAction(context: context);
          store.dispatch(action);
        }
      },
      builder: (BuildContext context, MuninVersionInfo muninVersion) {
        setNewestVersion(muninVersion);
        return ListTile(
          title: Text('更新'),
          trailing: latestVersionPrompt == null
              ? AdaptiveProgressIndicator()
              : _buildVersionWidget(),
          onTap: () {
            if (latestVersionPrompt == null) {
              launchByPreference(
                context,
                defaultDownloadUrl,
              );
            } else {
              launchByPreference(
                context,
                muninVersion.downloadPageUrl,
              );
            }
          },
        );
      },
    );
  }
}
