import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';

/// A [ChoiceChip] that has a background which is by default same as
/// CanvasColor of the Theme, textColor/borderColor is primary color if selected
class StrokeChoiceChip extends StatelessWidget {
  StrokeChoiceChip({
    Key key,
    this.avatar,
    @required this.label,
    this.labelStyle,
    this.labelPadding,
    this.onSelected,
    this.pressElevation,
    @required this.selected,
    this.selectedColor,
    this.disabledColor,
    this.tooltip,
    this.shape,
    this.clipBehavior = Clip.none,
    this.backgroundColor,
    this.padding,
    this.materialTapTargetSize,
    this.elevation,
    this.avatarBorder = const CircleBorder(),
  })  : assert(selected != null),
        assert(label != null),
        assert(clipBehavior != null),
        assert(pressElevation == null || pressElevation >= 0.0),
        assert(elevation == null || elevation >= 0.0);

  final Widget avatar;

  final Widget label;

  final TextStyle labelStyle;

  final EdgeInsetsGeometry labelPadding;

  final ValueChanged<bool> onSelected;

  final double pressElevation;

  final bool selected;

  final Color disabledColor;

  final Color selectedColor;

  final String tooltip;

  final ShapeBorder shape;

  final Clip clipBehavior;

  final Color backgroundColor;

  final EdgeInsetsGeometry padding;

  final MaterialTapTargetSize materialTapTargetSize;

  final double elevation;

  final ShapeBorder avatarBorder;

  Widget build(BuildContext context) {
    return ChoiceChip(
        key: key,
        avatar: avatar,
        label: label,
        labelPadding: labelPadding,
        onSelected: onSelected,
        pressElevation: pressElevation,
        selected: selected,
        selectedColor: selectedColor ?? Theme.of(context).canvasColor,
        disabledColor: disabledColor,
        tooltip: tooltip,
        shape: shape ??
            StadiumBorder(
                side: BorderSide(
                    color: selected
                        ? lightPrimaryDarkAccentColor(context)
                        : Theme.of(context).hintColor.withOpacity(0.2))),
        clipBehavior: clipBehavior,
        backgroundColor: Theme.of(context).canvasColor,
        padding: padding,
        materialTapTargetSize: materialTapTargetSize,
        elevation: elevation,
        avatarBorder: avatarBorder);
  }
}
