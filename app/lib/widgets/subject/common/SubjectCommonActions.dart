import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/subject/BangumiSubject.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';
import 'package:share/share.dart';

void _settingModalBottomSheet(BuildContext context, BangumiSubject subject) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.content_copy),
                  title: Text('复制标题'),
                  onTap: () {
                    ClipboardService.copyAsPlainText(context, subject.name,
                        popContext: true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.content_copy),
                  title: Text('复制简介'),
                  onTap: () {
                    ClipboardService.copyAsPlainText(context, subject.summary,
                        popContext: true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.content_copy),
                  title: Text('复制Staff信息'),
                  onTap: () {
                    ClipboardService.copyAsPlainText(
                        context, subject.infoBoxRowsPlainText,
                        popContext: true);
                  },
                ),
              ],
            ),
          ),
        );
      });
}

/// A list of common actions on subject page AppBar
List<Widget> subjectCommonActions(BuildContext context,
    BangumiSubject subject) {
  return [
    IconButton(
      icon: Icon(AdaptiveIcons.shareIconData),
      onPressed: () {
        Share.share('${subject.name} ${subject.pageUrlFromCalculation}');
      },
    ),
    IconButton(
      icon: Icon(AdaptiveIcons.moreActionsIconData),
      onPressed: () {
        _settingModalBottomSheet(context, subject);
      },
    ),
  ];
}
