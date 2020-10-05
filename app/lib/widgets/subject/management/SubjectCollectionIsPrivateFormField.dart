
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';

class SubjectCollectionIsPrivateFormField extends FormField<bool> {
  SubjectCollectionIsPrivateFormField({
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    ValueChanged<bool> onChanged,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> state) {
              return Container(
                child: SwitchListTile.adaptive(
                    title: const Text('仅自己可见'),
                    value: state.value,
                    onChanged: (value) {
                      state.didChange(value);
                      if (onChanged != null) {
                        onChanged(value);
                      }
                    },
                    activeColor: _getSwitchActiveColor(state.context)),
              );
            });

  /// on iOS, set secondary theme color as target color
  /// on other platforms, returns null(use widget default)
  static _getSwitchActiveColor(BuildContext context) {
    if (isCupertinoPlatform()) {
      return Theme.of(context).colorScheme.primary;
    }

    return null;
  }

  @override
  _SubjectCollectionIsPrivateFormFieldState createState() =>
      _SubjectCollectionIsPrivateFormFieldState();
}

class _SubjectCollectionIsPrivateFormFieldState extends FormFieldState<bool> {}
