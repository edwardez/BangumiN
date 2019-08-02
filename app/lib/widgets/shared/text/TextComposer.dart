import 'package:flutter/material.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/shared/exceptions/utils.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/form/SimpleFormSubmitWidget.dart';
import 'package:munin/widgets/shared/text/editor/BBCodeTextEditor.dart';
import 'package:munin/widgets/shared/text/editor/common.dart';
import 'package:quiver/strings.dart';

enum TextEditor {
  /// A plain text editor.
  Plain,

  /// A [BBCodeTextEditor].
  BBCode,
}

/// A general purpose text composer and sender.
class TextComposer extends StatefulWidget {
  final String appBarTitle;

  /// Initial text that should be populated in the editor.
  final String initialText;

  /// Widget that's on top of the text editor.
  final Widget widgetOnTop;

  /// Type of the editor.
  final TextEditor textEditor;

  final InputDecoration inputDecoration;

  final bool popContextOnSuccess;

  /// A prompt that'll shown up when user wants to go back to previous screen.
  final String onWillPopPromptTitle;

  /// A callback function that returns a [Future] to indicate status of
  /// submitting a reply.
  final Future<void> Function(
    BuildContext context,
    String reply,
  ) onSubmitReply;

  const TextComposer({
    Key key,
    @required this.appBarTitle,
    @required this.onSubmitReply,
    this.textEditor = TextEditor.BBCode,
    this.initialText,
    this.widgetOnTop,
    this.inputDecoration = const InputDecoration(
      labelText: '有什么想说的？',
      hintText: '',
      border: OutlineInputBorder(),
    ),
    this.popContextOnSuccess = true,
    this.onWillPopPromptTitle = '确认放弃发表这个回复？',
  }) : super(key: key);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController messageController = TextEditingController();

  RequestStatus submissionStatus = RequestStatus.Initial;
  bool _isMessageFieldValid = true;

  bool get _canSubmitForm => isNotEmpty(messageController.text);

  @override
  void initState() {
    super.initState();
    messageController.text = widget.initialText ?? '';
    messageController.addListener(_listenToMessageController);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  /// listen to message controller, set [_isMessageFieldValid] if form is currently invalid
  /// triggers a rebuild only if message validation status has changed
  _listenToMessageController() {
    if (!_canSubmitForm) {
      /// TODO: investigate how to correctly(?) disable submit button
      if (!_isMessageFieldValid) {
        setState(() {
          _isMessageFieldValid = true;
        });
      }
    } else {
      if (_isMessageFieldValid) {
        setState(() {
          _isMessageFieldValid = false;
        });
      }
    }
  }

  Widget _buildSubmitReplyButton() {
    return SimpleFormSubmitWidget(
      loadingStatus: submissionStatus,
      onSubmitPressed: (context) async {
        setState(() {
          submissionStatus = RequestStatus.Loading;
        });

        try {
          await widget.onSubmitReply(context, messageController.text);
          if (widget.popContextOnSuccess) {
            Navigator.of(context).pop(true);
          }
        } catch (error) {
          showTextOnSnackBar(context, formatErrorMessage(error));
          if (mounted) {
            setState(() {
              submissionStatus = RequestStatus.UnknownException;
            });
          }
        }
      },
      canSubmit: _canSubmitForm,
    );
  }

  Future<bool> _onDiscardReply() async {
    if (isNotEmpty(messageController.text)) {
      return await showMuninYesNoDialog(
        context, title: Text(widget.onWillPopPromptTitle),
        confirmAction: EditorYesNoPrompt.confirmAction,
        cancelAction: EditorYesNoPrompt.cancelAction,) ?? false;
    }

    return true;
  }

  Widget _buildTextEditor() {
    switch (widget.textEditor) {
      case TextEditor.Plain:
        return TextFormField(
          controller: messageController,
          decoration: widget.inputDecoration,
          minLines: editorMinLines,
          maxLines: editorMaxLines,
        );
      case TextEditor.BBCode:
      default:
        assert(widget.textEditor == TextEditor.BBCode);
        return BBCodeTextEditor(
          messageController: messageController,
          decoration: widget.inputDecoration,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        actions: <Widget>[
          _buildSubmitReplyButton(),
        ],
      ),
      body: MuninPadding.noVerticalOffset(
        denseHorizontal: true,
        child: ListView(
          children: <Widget>[
            // Disables [targetPost] for editing text as it might be confused.
            // ([initialText] already contains a quoted text.)
            if (widget.widgetOnTop != null)
              widget.widgetOnTop,
            Form(
              child: _buildTextEditor(),
              onWillPop: _onDiscardReply,
            ),
          ],
        ),
      ),
    );
  }
}
