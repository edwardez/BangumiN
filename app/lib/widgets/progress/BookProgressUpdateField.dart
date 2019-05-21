import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldType { Episode, Volume }

/// A [TextFormField] that updates book progress
/// It allows user to enter a new number for their book progress
/// i.e. If `fieldType` is [FieldType.Episode], user can update how many episodes
/// of the book they've read
/// It would be nice if we can use a numeric-only keyboard here, however a mumeric-only
/// keyboard results in no DONE button in some keyboard
/// see https://github.com/flutter/flutter/issues/12220

class BookProgressUpdateField extends StatelessWidget {
  /// It's unlikely someone watches more than 10^10 episodes/volumes.
  static const maxInputLength = 10;

  final FieldType fieldType;

  /// Total number of episode/volume for the subject
  final int maxNumber;

  /// Subject id of the corresponding subject
  final int subjectId;

  /// Current number of episode/volume user has read should be initialized with
  /// controller
  final TextEditingController textEditingController;

  const BookProgressUpdateField(
      {Key key,
      @required this.fieldType,
      @required this.maxNumber,
      @required this.subjectId,
      @required this.textEditingController})
      : super(key: key);

  String fieldTypeToChinese(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.Volume:
        return '卷';
      case FieldType.Episode:
      default:
        return '话';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: PageStorageKey<String>('progress-book-$fieldType-$subjectId'),
      controller: textEditingController,
      autocorrect: false,
      textAlign: TextAlign.end,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(BookProgressUpdateField.maxInputLength)
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: false,
        suffixText: '/${maxNumber ?? '??'}${fieldTypeToChinese(fieldType)}',
      ),
    );
  }
}
