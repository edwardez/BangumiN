import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/PublicMessageNormal.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/redux/timeline/TimelineActions.dart';
import 'package:munin/widgets/shared/text/TextComposer.dart';

class PublicMessageReplyComposer extends StatelessWidget {
  final String initialText;

  /// A widget that's on top of text editor.
  final Widget widgetOnTop;

  final PublicMessageNormal mainMessage;

  const PublicMessageReplyComposer({
    Key key,
    @required this.widgetOnTop,
    @required this.mainMessage,
    this.initialText,
  }) : super(key: key);

  Future<void> _submitReply(
    BuildContext context,
    String reply,
  ) async {
    final action = CreatePublicMessageReplyRequestAction(
      reply: reply,
      mainMessage: mainMessage,
    );

    findStore(context).dispatch(action);

    return action.completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return TextComposer(
      onSubmitReply: _submitReply,
      appBarTitle: '回复此时间线',
      widgetOnTop: widgetOnTop,
      textEditor: TextEditor.Plain,
      initialText: initialText,
    );
  }
}
