import 'package:flutter/material.dart';

const defaultPortraitHorizontalPadding = 24.0;
const defaultDensePortraitHorizontalPadding = 16.0;
const defaultLandScapeHorizontalPadding = 48.0;
const defaultLandScapeDenseHorizontalPadding = 16.0;
const defaultAppBarElevation = 4.0;
const defaultImageCircularRadius = 4.0;
const defaultIconSize = 24.0;

/// 87.5% of the default icon size
const smallerIconSize = defaultIconSize * 0.875;

TextStyle body1TextWithPrimaryColor(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .body1
      .copyWith(color: Theme.of(context).primaryColor);
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
