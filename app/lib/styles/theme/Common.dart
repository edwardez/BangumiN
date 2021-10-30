import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 4 dp is typically the smallest spacing of material
/// https://material.io/design/layout/spacing-methods.html
const baseOffset = 4.0;

const onePixelOffset = 1.0;
const smallOffset = baseOffset;
const mediumOffset = baseOffset * 2;
const baseOffset3x = baseOffset * 3;
const largeOffset = baseOffset3x;
const baseOffset4x = baseOffset * 4;

const bottomOffset = baseOffset * 10;

final defaultContainerCircularRadius = BorderRadius.circular(8.0);

const defaultPortraitHorizontalOffset = baseOffset * 6;
const defaultPortraitHorizontalEdgeInsets =
    const EdgeInsets.symmetric(horizontal: defaultPortraitHorizontalOffset);
const defaultDensePortraitHorizontalOffset = baseOffset4x;
const defaultLandScapeHorizontalOffset = baseOffset * 12;
const defaultLandScapeDenseHorizontalOffset = baseOffset4x;
const defaultAppBarElevation = 4.0;
const defaultImageCircularRadius = 4.0;
final defaultIconSize = IconThemeData.fallback().size;

/// 87.5% of the default icon size
final smallerIconSize = defaultIconSize * 0.875;

TextTheme textTheme(BuildContext context) {
  return Theme
      .of(context)
      .textTheme;
}

TextStyle body1TextWithLightPrimaryDarkAccentColor(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyText1
      .copyWith(color: lightPrimaryDarkAccentColor(context));
}

TextStyle body1ErrorText(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyText1
      .copyWith(color: Theme
      .of(context)
      .errorColor);
}

TextStyle defaultCaptionText(BuildContext context) {
  return Theme.of(context).textTheme.caption;
}

Color defaultCaptionTextColorOrFallback(BuildContext context) {
  if (context != null) {
    return defaultCaptionText(context).color;
  }
  return Colors.black54;
}

/// A caption text with a higher opacity.
TextStyle captionTextWithHigherOpacity(BuildContext context,
    [double scale = 1.25]) {
  return captionTextWithCustomizedOpacity(
    context,
    scale,
  );
}

TextStyle captionTextWithCustomizedOpacity(BuildContext context,
    [double scale = 1]) {
  scale ??= 1;

  TextStyle defaultCaption = defaultCaptionText(context);

  double higherOpacity = math.min(1.0, defaultCaption.color.opacity * scale);

  return defaultCaption.copyWith(
      color: defaultCaption.color.withOpacity(higherOpacity));
}

TextStyle captionTextWithBody1Size(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .caption
      .copyWith(fontSize: Theme.of(context).textTheme.bodyText2.fontSize);
}

TextStyle scoreStyle(BuildContext context, {fontSize = 18.0}) {
  return Theme.of(context)
      .textTheme
      .bodyText1
      .copyWith(fontSize: fontSize, color: MuninColor.score);
}

class MuninColor {
  static const Color score = Color(0xFFFFAC2D);
}

Color lightPrimaryDarkAccentColor(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return Theme.of(context).accentColor;
  }

  return Theme.of(context).primaryColor;
}

TextStyle defaultDialogContentTextStyle(BuildContext context) {
  return Theme
      .of(context)
      .dialogTheme
      .contentTextStyle ??
      Theme
          .of(context)
          .textTheme
          .subtitle1;
}
