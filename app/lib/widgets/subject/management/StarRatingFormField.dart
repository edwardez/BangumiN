import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/subject/management/StarRating.dart';

class StarRatingFormField extends FormField<int> {
  StarRatingFormField(
      {FormFieldSetter<int> onSaved,
      FormFieldValidator<int> validator,
      int initialValue = 0,
        double horizontalPadding = defaultPortraitHorizontalOffset,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<int> state) {
              return StarRating(
                  rating: state.value.toDouble(),
                  onRatingChanged: (double rating) =>
                      state.didChange(rating.toInt()),
                  horizontalPadding: horizontalPadding);
            });

  @override
  _StarRatingFormFieldState createState() => _StarRatingFormFieldState();
}

class _StarRatingFormFieldState extends FormFieldState<int> {}
