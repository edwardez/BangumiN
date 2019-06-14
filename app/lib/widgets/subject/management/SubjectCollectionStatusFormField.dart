import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';

typedef void ChipSelectedCallBack(CollectionStatus status);

class SubjectCollectionStatusFormField extends FormField<CollectionStatus> {
  static const selectableCollectionStatus = [
    CollectionStatus.Wish,
    CollectionStatus.Completed,
    CollectionStatus.InProgress,
    CollectionStatus.OnHold,
    CollectionStatus.Dropped,
  ];

  static _onChipSelected(FormFieldState<CollectionStatus> state, bool selected,
      CollectionStatus status, ChipSelectedCallBack chipSelectedCallBack) {
    assert(!CollectionStatus.isInvalid(status));
    if (selected) {
      state.didChange(status);
      if (chipSelectedCallBack != null) {
        chipSelectedCallBack(status);
      }
    }
  }

  /// If `isDarkTheme` is set to true, FilterChip will be used
  /// If `isDarkTheme` is set to false, ChoiceChip will be used
  /// This is an workaround for a current bug in ChoiceChip under dark theme
  static Widget workaroundChip(FormFieldState<CollectionStatus> state,
      CollectionStatus collectionStatus, SubjectType subjectType,
      bool isDarkTheme, ChipSelectedCallBack onChipSelected) {
    if (isDarkTheme) {
      return FilterChip(
        label:
        Text(CollectionStatus.chineseNameWithSubjectType(
            collectionStatus, subjectType)),
        selected: state.value == collectionStatus,
        onSelected: (bool selected) {
          _onChipSelected(state, selected, collectionStatus,
              onChipSelected);
        },
      );
    }

    return ChoiceChip(
      label:
      Text(CollectionStatus.chineseNameWithSubjectType(
          collectionStatus, subjectType)),
      selected: state.value == collectionStatus,
      onSelected: (bool selected) {
        _onChipSelected(state, selected, collectionStatus,
            onChipSelected);
      },
    );
  }


  SubjectCollectionStatusFormField({@required SubjectType subjectType,
    @required bool isDarkTheme,
    FormFieldSetter<CollectionStatus> onSaved,
    FormFieldValidator<CollectionStatus> validator,
    ChipSelectedCallBack onChipSelected,
    CollectionStatus initialStatus = CollectionStatus.Pristine,
    bool autovalidate = false,
  })
      : assert(subjectType != null),

  /// selectableCollectionStatus must not contain duplicates
        assert(Set
            .from(selectableCollectionStatus)
            .length == selectableCollectionStatus.length),
        super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialStatus,
          autovalidate: autovalidate,
          builder: (FormFieldState<CollectionStatus> state) {
            return Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                for (var collectionStatus in selectableCollectionStatus)
                  workaroundChip(
                      state, collectionStatus, subjectType, isDarkTheme,
                      onChipSelected)
              ],
            );
          });

  @override
  _SubjectCollectionStatusFormFieldState createState() {
    return _SubjectCollectionStatusFormFieldState();
  }
}

class _SubjectCollectionStatusFormFieldState
    extends FormFieldState<CollectionStatus> {}

@override
Widget build(BuildContext context) {
  return null;
}
