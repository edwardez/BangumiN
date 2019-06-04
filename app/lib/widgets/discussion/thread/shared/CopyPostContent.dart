import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';

class CopyPostContent extends StatelessWidget {
  final String contentHtml;

  const CopyPostContent({Key key, @required this.contentHtml})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.content_copy),
      title: Text('复制内容'),
      onTap: () {
        Navigator.pop(context);
        var postContent = (parseFragment(contentHtml).text ?? '').trim();
        ClipboardService.copyAsPlainText(context, postContent);
      },
    );
  }
}
