import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/discussion/thread/common/GetThreadRequest.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/providers/bangumi/discussion/BangumiDiscussionService.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/shared/utils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/discussion/common/DiscussionReplyWidgetComposer.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';

class PostEditor extends StatefulWidget {
  final int replyId;

  final int threadId;

  final ThreadType threadType;

  const PostEditor({
    Key key,
    @required this.replyId,
    @required this.threadId,
    @required this.threadType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostEditorState();
  }
}

class _PostEditorState extends State<PostEditor> {
  final bangumiDiscussionService = getIt.get<BangumiDiscussionService>();

  Future requestStatusFuture;

  String replyContent;

  @override
  Widget build(BuildContext context) {
    if (replyContent == null) {
      return RequestInProgressIndicatorWidget(
        requestStatusFuture: requestStatusFuture,
        retryCallback: (_) => _loadReplyContent(),
      );
    }

    final threadType = widget.threadType;
    final replyId = widget.replyId;

    return DiscussionReplyWidgetComposer.forEditReply(
      threadType: threadType,
      threadId: replyId,
      initialText: replyContent,
      onEditReplySubmitted: (BuildContext context, String reply) {
        final responseFuture =
            bangumiDiscussionService.updateReply(replyId, threadType, reply);
        responseFuture.then((_) {
          final getThreadRequestAction = GetThreadRequestAction(
            request: GetThreadRequest((b) => b
              ..threadType = threadType
              ..id = widget.threadId),
            captionTextColor: defaultCaptionTextColorOrFallback(context),
          );
          findStore(context).dispatch(getThreadRequestAction);
        });
        return responseFuture;
      },
    );
  }

  Future _loadReplyContent() {
    requestStatusFuture = bangumiDiscussionService.getReplyContentForEdit(
      widget.replyId,
      widget.threadType,
    );

    requestStatusFuture.then((content) {
      if (mounted) {
        setState(() {
          replyContent = content;
        });
      }
    });
    return requestStatusFuture;
  }

  @override
  void initState() {
    super.initState();
    _loadReplyContent();
  }
}
