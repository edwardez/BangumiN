import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/models/bangumi/timeline/message/PublicMessageReply.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/RoundedConcreteBackgroundWithChild.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';
import 'package:munin/widgets/timeline/message/Common.dart';
import 'package:munin/widgets/timeline/message/PublicMessageReplyComposer.dart';

class PublicMessageReplyWidget extends StatelessWidget {
  final PublicMessageNormal mainMessage;

  final PublicMessageReply publicMessageReply;

  const PublicMessageReplyWidget({
    Key key,
    @required this.publicMessageReply,
    @required this.mainMessage,
  }) : super(key: key);

  static Widget buildQuotedTextWidget(String html) {
    return Padding(
      padding: const EdgeInsets.only(bottom: mediumOffset),
      child: RoundedConcreteBackgroundWithChild(
        child: BangumiHtml(
          html: firstNChars(html, 1000),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: baseOffset),
        child: BangumiHtml(
          html: publicMessageReply.contentHtml,
        ),
      ),
      onTap: () {
        showMinHeightModalBottomSheet(context, [
          ListTile(
            title: Text('复制内容'),
            onTap: () {
              ClipboardService.copyAsPlainText(
                context,
                publicMessageReply.contentText,
                popContext: true,
              );
            },
          ),
          ListTile(
            title: Text('回复'),
            onTap: () {
              Navigator.pop(context);
              showSnackBarOnSuccess(
                  context,
                  Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PublicMessageReplyComposer(
                            mainMessage: mainMessage,
                            widgetOnTop: buildQuotedTextWidget(
                                publicMessageReply.contentHtml),
                            initialText:
                                '@${publicMessageReply.author.username} ',
                          ),
                    ),
                  ),
                  onReplySuccessText);
            },
          ),
          if (publicMessageReply.author.username ==
              findAppState(context).currentAuthenticatedUserBasicInfo.username)
            ListTile(
              title: Text(
                '修改或删除回复',
                style: captionTextWithBody1Size(context),
              ),
              subtitle: Text('Bangumi不允许直接修改或删除时间线回复'),
            ),
        ]);
      },
    );
  }
}
