import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/discussion/thread/common/Post.dart';
import 'package:munin/models/bangumi/discussion/thread/common/ThreadType.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/discussion/DiscussionActions.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/background/RoundedConcreteBackgroundWithChild.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/form/SimpleFormSubmitWidget.dart';
import 'package:munin/widgets/shared/text/editor/BBCodeTextEditor.dart';
import 'package:quiver/strings.dart';
import 'package:redux/redux.dart';

class ComposeDiscussionReplyWidget extends StatefulWidget {
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
  /// [ComposeDiscussionReplyWidget] is used to edit a existing reply.
  final String initialText;

  const ComposeDiscussionReplyWidget.forCreateReply({
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

  @override
  _ComposeDiscussionReplyWidgetState createState() =>
      _ComposeDiscussionReplyWidgetState();
}

class _ComposeDiscussionReplyWidgetState
    extends State<ComposeDiscussionReplyWidget> {
  final TextEditingController messageController = TextEditingController();

  RequestStatus submissionStatus = RequestStatus.Initial;

  @override
  void initState() {
    super.initState();
    messageController.text = widget.initialText ?? '';
  }

  Widget _buildQuotedTextWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: mediumOffset),
      child: RoundedConcreteBackgroundWithChild.fromText(
        '${widget.targetPost.author.nickname}: ${widget.targetPost.authorPostedText}',
        context,
        maxLines: ComposeDiscussionReplyWidget.quotedReplyMaxLines,
      ),
    );
  }

  Widget _buildSubmitReplyButton(_ViewModel vm) {
    return SimpleFormSubmitWidget(
      loadingStatus: submissionStatus,
      onSubmitPressed: (context) async {
        setState(() {
          submissionStatus = RequestStatus.Loading;
        });

        try {
          await vm.createReply(context, messageController.text);
          Navigator.of(context).pop(true);
        } catch (error) {
          showTextOnSnackBar(context, formatErrorMessage(error));
          if (mounted) {
            setState(() {
              submissionStatus = RequestStatus.UnknownException;
            });
          }
        }
      },
      canSubmit: messageController.text != null,
    );
  }

  Future<bool> _onDiscardReply() async {
    if (isNotEmpty(messageController.text)) {
      return await showMuninConfirmActionDialog(context,
              title: '确认放弃发表这个回复？') ??
          false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(
          store, widget.threadId, widget.threadType, widget.targetPost),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.appBarTitle),
            actions: <Widget>[
              _buildSubmitReplyButton(vm),
            ],
          ),
          body: MuninPadding.noVerticalOffset(
            denseHorizontal: true,
            child: ListView(
              children: <Widget>[
                // Disables [targetPost] for editing text as it might be confused.
                // ([initialText] already contains a quoted text.)
                if (widget.targetPost != null && widget.initialText == null)
                  _buildQuotedTextWidget(context),
                if (widget.targetPost == null)
                  Padding(
                    padding: EdgeInsets.only(top: mediumOffset),
                  ),
                Form(
                  child: BBCodeTextEditor(
                    messageController: messageController,
                  ),
                  onWillPop: _onDiscardReply,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Future<void> Function(BuildContext context, String reply) createReply;

  factory _ViewModel.fromStore(
    Store<AppState> store,
    int threadId,
    ThreadType threadType,
    Post targetPost,
  ) {
    Future<void> _createReply(
      BuildContext context,
      String reply,
    ) async {
      final action = CreateReplyRequestAction(
          threadType: threadType,
          reply: reply,
          targetPost: targetPost,
          threadId: threadId,
          context: context);

      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      createReply: _createReply,
    );
  }

  const _ViewModel({this.createReply});
}
