import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreActions extends StatelessWidget {
  final BangumiThread thread;
  final BangumiContent parentBangumiContent;

  /// Whether currently all spoilers are visible or not.
  /// It is used to change text on bottom sheet menu. To actually toggle spoilers,
  /// there must be a valid [toggleSpoilerCallback] implementation(caller is
  /// responsible for implementation).
  /// If [allSpoilersVisible] is not null, [toggleSpoilerCallback] must be non-null.
  final bool allSpoilersVisible;

  /// A callback that reveals or hides all spoilers.
  /// Setting it to null removes relevant action from the bottom sheet.
  /// If [toggleSpoilerCallback] is not null, [allSpoilersVisible] must be non-null.
  final Function() toggleSpoilerCallback;

  const MoreActions({
    Key key,
    @required this.thread,
    @required this.parentBangumiContent,
    this.allSpoilersVisible,
    this.toggleSpoilerCallback,
  }) : super(key: key);

  String toggleSpoilerMenuName() {
    String spoilerTypeText = '';

    if (parentBangumiContent == BangumiContent.Episode) {
      spoilerTypeText = '剧透';
    } else {
      spoilerTypeText = '文字';
    }

    if (allSpoilersVisible) {
      return '一键隐藏本页所有$spoilerTypeText反白';
    } else {
      return '一键显示本页所有$spoilerTypeText反白';
    }
  }

  Icon toggleSpoilerMenuIcon() {
    if (allSpoilersVisible) {
      return Icon(OMIcons.visibilityOff);
    } else {
      return Icon(OMIcons.visibility);
    }
  }

  _showMoreActionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (innerContext) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.open_in_browser),
                  title: Text(openInBrowser),
                  onTap: () {
                    var maybeWebUrl = generateWebPageUrlByContentType(
                        parentBangumiContent, thread.id.toString());

                    if (maybeWebUrl.isPresent) {
                      launch(maybeWebUrl.value);
                    } else {
                      showTextOnSnackBar(context, '网址无效');
                    }
                    Navigator.of(context).pop();
                  },
                ),
                if (toggleSpoilerCallback != null)
                  ListTile(
                    leading: toggleSpoilerMenuIcon(),
                    title: Text(toggleSpoilerMenuName()),
                    onTap: () {
                      toggleSpoilerCallback();
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    assert(allSpoilersVisible == null && toggleSpoilerCallback == null ||
        allSpoilersVisible != null && toggleSpoilerCallback != null);

    return IconButton(
      icon: Icon(AdaptiveIcons.moreActionsIconData),
      onPressed: () {
        _showMoreActionsBottomSheet(context);
      },
    );
  }
}
