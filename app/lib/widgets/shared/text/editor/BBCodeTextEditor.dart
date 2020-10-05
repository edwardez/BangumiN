import 'dart:math' show max, min;

import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/button/RoundedInkWell.dart';
import 'package:munin/widgets/shared/text/editor/common.dart';
import 'package:munin/widgets/shared/text/editor/showBangumiStickersBottomSheet.dart';
import 'package:munin/widgets/shared/text/editor/sticker/BangumiSticker.dart';
import 'package:munin/widgets/shared/text/editor/sticker/utils.dart';

class BBCodeTextEditor extends StatefulWidget {
  /// The external [TextEditingController].
  /// It's the responsibility of the controller provider to dispose it.
  final TextEditingController messageController;

  final InputDecoration decoration;

  const BBCodeTextEditor({
    Key key,
    this.messageController,
    this.decoration = const InputDecoration(
      labelText: '有什么想说的？',
      hintText: '',
      border: OutlineInputBorder(),
    ),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BBCodeTextEditorState();
  }
}

class _BBCodeTextEditorState extends State<BBCodeTextEditor> {
  TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = widget.messageController;
    messageController ??= TextEditingController(text: '');
  }

  /// Inserts a markup after [previousSelection.baseOffset], or if
  /// [previousSelection.baseOffset] is smaller than 0, inserts [text] at the
  /// start. [rightInsertion] is an optional parameter.
  ///
  /// If some text is selected, [leftInsertion] will be before the selected text,
  /// [rightInsertion] will be after the selected text. Cursor is after [rightInsertion].
  ///
  /// If no text is selected, it will be inserted as
  /// [leftInsertion](cursor position)[rightInsertion]. A null [rightInsertion]
  /// won't take effect.
  void insertMarkup(
    TextSelection previousSelection, {
    @required String leftInsertion,
    String rightInsertion = '',
  }) {
    String updatedText;
    int newCursorPosition;

    final smallerSelectionPosition = max(
        min(previousSelection.extentOffset, previousSelection.baseOffset), 0);
    final largerSelectionPosition = max(
        max(previousSelection.extentOffset, previousSelection.baseOffset), 0);

    final currentText = messageController.text ?? '';
    final textBeforeCursor =
        '${currentText.substring(0, smallerSelectionPosition)}';

    /// No text is selected by user.
    if (smallerSelectionPosition == largerSelectionPosition) {
      final textBeforeRightInsertion = '$textBeforeCursor$leftInsertion';
      updatedText =
          '$textBeforeRightInsertion$rightInsertion${currentText.substring(smallerSelectionPosition)}';
      newCursorPosition = textBeforeRightInsertion.length;
    } else {
      final selectedText =
          '${currentText.substring(smallerSelectionPosition, largerSelectionPosition)}';
      final textBeforeInsertionEnd = '$textBeforeCursor$leftInsertion'
          '$selectedText$rightInsertion';

      updatedText = '$textBeforeInsertionEnd'
          '${currentText.substring(largerSelectionPosition)}';
      newCursorPosition = textBeforeInsertionEnd.length;
    }

    messageController.value = messageController.value.copyWith(
        text: updatedText,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: newCursorPosition,
            affinity: previousSelection.affinity,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: messageController,
          autocorrect: false,
          decoration: widget.decoration,
          validator: (value) {},
          minLines: editorMinLines,
          maxLines: editorMaxLines,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: baseOffset),
          child: Wrap(
            spacing: mediumOffset,
            children: <Widget>[
              RoundedInkWell(
                child: Icon(Icons.format_bold_rounded),
                onTap: () {
                  insertMarkup(messageController.selection,
                      leftInsertion: '[b]', rightInsertion: '[/b]');
                },
                tooltip: '加粗',
              ),
              RoundedInkWell(
                child: Icon(Icons.format_italic_rounded),
                onTap: () {
                  insertMarkup(messageController.selection,
                      leftInsertion: '[i]', rightInsertion: '[/i]');
                },
                tooltip: '斜体',
              ),
              RoundedInkWell(
                child: Icon(Icons.format_strikethrough_rounded),
                onTap: () {
                  insertMarkup(messageController.selection,
                      leftInsertion: '[s]', rightInsertion: '[/s]');
                },
                tooltip: '删除线',
              ),
              RoundedInkWell(
                child: Icon(Icons.format_underline_rounded),
                onTap: () {
                  insertMarkup(messageController.selection,
                      leftInsertion: '[u]', rightInsertion: '[/u]');
                },
                tooltip: '下划线',
              ),
              RoundedInkWell(
                child: Icon(Icons.subject_rounded),
                onTap: () {
                  insertMarkup(messageController.selection,
                      leftInsertion: '[mask]', rightInsertion: '[/mask]');
                },
                tooltip: '马塞克',
              ),
              RoundedInkWell(
                child: BangumiSticker(
                  id: 24,
                  padding: EdgeInsets.zero,
                  stickerSize: defaultIconSize,
                ),
                onTap: () {
                  // Cache current selection position as bottom sheet
                  // resets position to origin.
                  final currentSelection = messageController.selection;
                  showBangumiStickersBottomSheet(
                    context,
                    (int id) {
                      insertMarkup(
                        currentSelection,
                        leftInsertion: idToBangumiStickerCode(id),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
                tooltip: '表情',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
