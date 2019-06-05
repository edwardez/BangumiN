import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';

class CopyPostContent extends StatelessWidget {
  final String contentHtml;

  /// An additional context that's under a scaffold. If non-null, copy snackbar
  /// messages are shown under [contextWithScaffold].
  /// It's useful if [CopyPostContent] itself is put in a place with no scaffold.
  final BuildContext contextWithScaffold;

  const CopyPostContent(
      {Key key, @required this.contentHtml, this.contextWithScaffold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.content_copy),
      title: Text('复制内容'),
      onTap: () {
        Navigator.pop(context);
        var postContent = (parseFragment(contentHtml).text ?? '').trim();
        ClipboardService.copyAsPlainText(
            contextWithScaffold ?? context, postContent);
      },
    );
  }
}
