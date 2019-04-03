import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/subject/management/SubjectTagsField.dart';

class SubjectTagsFormField extends FormField<Set<String>> {
  ///[headerTags] is always a subset of [candidateTags.keys]
  SubjectTagsFormField({
    FormFieldSetter<Set<String>> onSaved,
    FormFieldValidator<Set<String>> validator,
    @required LinkedHashMap<String, bool> headerTags,
    @required LinkedHashMap<String, bool> candidateTags,
    double horizontalPadding = defaultPortraitHorizontalPadding,
    bool autovalidate = false,
    int maxTags = 10,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: headerTags.keys.toSet(),
            autovalidate: autovalidate,
            builder: (FormFieldState<Set<String>> state) {
              return SubjectTagsField(
                headerTags: headerTags,
                candidateTags: candidateTags,
                maxTags: maxTags,
                onChanged: state.didChange,
              );
            });

  @override
  _StarRatingFormFieldState createState() => _StarRatingFormFieldState();
}

class _StarRatingFormFieldState extends FormFieldState<Set<String>> {}
