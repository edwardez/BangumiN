import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/RoundedConcreteBackgroundWithChild.dart';
import 'package:munin/widgets/shared/text/TextComposer.dart';

class DiscussionReplyWidgetComposer extends StatelessWidget {
  /// Truncates reply to this length.
  /// Note that to ensure performance, raw html instead of text is truncated.
  /// (so we don't need to parse the html one more time).
  static const quotedReplyMaxLines = 5;

  /// Id of the thread,
  final int threadId;

  final ThreadType threadType;

  /// The target post that reply is sent against.
  /// Can be null if this reply is directly
  /// sent to the main post.
  final Post targetPost;

  final String appBarTitle;

  /// Initial text that should be populated in the editor. It's used if
  /// [DiscussionReplyWidgetComposer] is used to edit a existing reply.
  final String initialText;

  const DiscussionReplyWidgetComposer.forCreateReply({
    Key key,
    @required this.threadId,
    @required this.threadType,
    this.targetPost,
    this.appBarTitle = '编写回复',
  })
      : initialText = null,
        super(key: key);

//  const ComposeDiscussionReplyWidget.forEditReply({
//    Key key,
//    @required this.threadType,
//    @required this.threadId,
//    @required this.initialText,
//    @required this.targetPost,
//    this.appBarTitle = '编写回复',
//  }) : super(key: key);

  Future<void> _submitReply(BuildContext context,
      String reply,) async {
    final action = CreateReplyRequestAction(
        threadType: threadType,
        reply: reply,
        targetPost: targetPost,
        threadId: threadId,
        context: context);

    findStore(context).dispatch(action);

    return action.completer.future;
  }

  Widget _buildQuotedTextWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: mediumOffset),
      child: RoundedConcreteBackgroundWithChild.fromText(
        '${targetPost.author.nickname}: ${targetPost.authorPostedText}',
        context,
        maxLines: DiscussionReplyWidgetComposer.quotedReplyMaxLines,
      ),
    );
  }

  Widget _buildQuotedTextWidgetOrPadding(BuildContext context) {
    if (targetPost != null && initialText == null) {
      return _buildQuotedTextWidget(context);
    } else {
      return Padding(
        padding: EdgeInsets.only(top: mediumOffset),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextComposer(
      appBarTitle: appBarTitle,
      onSubmitReply: _submitReply,
      initialText: initialText,
      widgetOnTop: _buildQuotedTextWidgetOrPadding(context),
    );
  }
}
