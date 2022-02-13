import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldType { Episode, Volume }

/// A [TextFormField] that updates book progress
/// It allows user to enter a new number for their book progress
/// i.e. If `fieldType` is [FieldType.Episode], users can update number of
/// episodes of the book they've read.
///
/// It would be nice if we can use a numeric-only keyboard here, however a numeric-only
/// keyboard results in no DONE button in some keyboard
/// see https://github.com/flutter/flutter/issues/12220
class BookProgressUpdateField extends StatelessWidget {
  /// It's unlikely someone watches more than 10^10 episodes/volumes.
  static const maxInputLength = 10;

  final FieldType fieldType;

  /// Total number of episode/volume for the subject.
  final int totalEpisodesOrVolumeCount;

  /// Subject id of the corresponding subject.
  final int subjectId;

  /// Current number of episode/volume user has read should be initialized with
  /// controller.
  final TextEditingController textEditingController;

  final FormFieldSetter<String> onSaved;

  final String pageStorageKeyPrefix;

  const BookProgressUpdateField(
      {Key key,
      @required this.fieldType,
      @required this.totalEpisodesOrVolumeCount,
      @required this.subjectId,
      @required this.textEditingController,
      this.onSaved,
      this.pageStorageKeyPrefix = 'progress'})
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
      key: PageStorageKey<String>(
          '$pageStorageKeyPrefix-book-$fieldType-$subjectId'),
      controller: textEditingController,
      autocorrect: false,
      textAlign: TextAlign.end,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(BookProgressUpdateField.maxInputLength)
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: false,
        suffixText:
            '/${totalEpisodesOrVolumeCount ?? '??'}${fieldTypeToChinese(fieldType)}',
      ),
      onSaved: onSaved,
    );
  }
}
