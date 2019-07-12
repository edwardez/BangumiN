import 'package:flutter/material.dart';

/// A [ChoiceChip] that has a background which is by default same as
/// CanvasColor of the Theme, textColor/borderColor is the same, as set by the
/// pass-in parameter.
///
class StrokeChip extends StatelessWidget {
  /// Callback when the chip is pressed.
  /// If [onPressed] is null, a [RawChip] instead of [ActionChip] will be used.
  final VoidCallback onPressed;

  final Color borderColor;

  /// Label on the chip.
  final Widget label;

  const StrokeChip({
    Key key,
    @required this.borderColor,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = StadiumBorder(
        side: BorderSide(
      color: borderColor,
    ));

    if (onPressed == null) {
      return RawChip(
        label: label,
        backgroundColor: Theme.of(context).canvasColor,
        shape: shape,
      );
    }

    return ActionChip(
      onPressed: onPressed,
      label: label,
      backgroundColor: Theme.of(context).canvasColor,
      shape: shape,
    );
  }
}
