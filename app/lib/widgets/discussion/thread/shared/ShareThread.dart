import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/common/BangumiThread.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:share/share.dart';

class ShareThread extends StatelessWidget {
  final BangumiThread thread;
  final BangumiContent parentBangumiContent;

  const ShareThread(
      {Key key, @required this.thread, @required this.parentBangumiContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(AdaptiveIcons.shareIconData),
      onPressed: () {
        String url;

        generateWebPageUrlByContentType(
            parentBangumiContent, thread.id.toString())
          ..ifPresent((pageUrl) {
            url = pageUrl;
          })
          ..ifAbsent(() {
            url = '';
          });

        Share.share('${thread.title}\n$url');
      },
    );
  }
}
