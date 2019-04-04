import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/Bangumi/subject/common/SubjectType.dart';

typedef void ChipSelectedCallBack(CollectionStatus status);

class SubjectCollectionStatusFormField extends FormField<CollectionStatus> {
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

  SubjectCollectionStatusFormField(
      {@required SubjectType subjectType,
      FormFieldSetter<CollectionStatus> onSaved,
      FormFieldValidator<CollectionStatus> validator,
      ChipSelectedCallBack onChipSelected,
      CollectionStatus initialStatus = CollectionStatus.Untouched,
      bool autovalidate = false})
      : assert(subjectType != null),
        super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialStatus,
            autovalidate: autovalidate,
            builder: (FormFieldState<CollectionStatus> state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ChoiceChip(
                    label:
                        Text('想${subjectType.activityVerbChineseNameByType}'),
                    selected: state.value == CollectionStatus.Wish,
                    onSelected: (bool selected) {
                      _onChipSelected(state, selected, CollectionStatus.Wish,
                          onChipSelected);
                    },
                  ),
                  ChoiceChip(
                    label:
                        Text('${subjectType.activityVerbChineseNameByType}过'),
                    selected: state.value == CollectionStatus.Collect,
                    onSelected: (bool selected) {
                      _onChipSelected(state, selected, CollectionStatus.Collect,
                          onChipSelected);
                    },
                  ),
                  ChoiceChip(
                    label:
                        Text('在${subjectType.activityVerbChineseNameByType}'),
                    selected: state.value == CollectionStatus.Do,
                    onSelected: (bool selected) {
                      _onChipSelected(
                          state, selected, CollectionStatus.Do, onChipSelected);
                    },
                  ),
                  ChoiceChip(
                    label: Text('搁置'),
                    selected: state.value == CollectionStatus.OnHold,
                    onSelected: (bool selected) {
                      _onChipSelected(state, selected, CollectionStatus.OnHold,
                          onChipSelected);
                    },
                  ),
                  ChoiceChip(
                    label: Text('抛弃'),
                    selected: state.value == CollectionStatus.Dropped,
                    onSelected: (bool selected) {
                      _onChipSelected(state, selected, CollectionStatus.Dropped,
                          onChipSelected);
                    },
                  ),
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
