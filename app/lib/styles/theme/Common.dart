import 'package:flutter/material.dart';

const xsVerticalPadding = 1.0;
const smallVerticalPadding = 5.0;
const largeVerticalPadding = 10.0;

const defaultPortraitHorizontalPadding = 24.0;
const defaultDensePortraitHorizontalPadding = 16.0;
const defaultLandScapeHorizontalPadding = 48.0;
const defaultLandScapeDenseHorizontalPadding = 16.0;
const defaultAppBarElevation = 4.0;
const defaultImageCircularRadius = 4.0;
const defaultIconSize = 24.0;

/// 87.5% of the default icon size
const smallerIconSize = defaultIconSize * 0.875;

TextStyle body1TextWithLightPrimaryDarkAccentColor(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .body1
      .copyWith(color: lightPrimaryDarkAccentColor(context));
}

TextStyle captionTextWithBody1Size(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .caption
      .copyWith(fontSize: Theme.of(context).textTheme.body1.fontSize);
}

TextStyle scoreStyle(BuildContext context, {fontSize = 18.0}) {
  return Theme.of(context)
      .textTheme
      .body1
      .copyWith(fontSize: fontSize, color: MuninColor.score);
}

class MuninColor {
  static const Color score = Color(0xFFFFAC2D);
}

Color lightPrimaryDarkAccentColor(BuildContext context) {
  if (Theme
      .of(context)
      .brightness == Brightness.dark) {
    return Theme
        .of(context)
        .accentColor;
  }

  return Theme
      .of(context)
      .primaryColor;
}
