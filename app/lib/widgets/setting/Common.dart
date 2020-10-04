import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';

Icon selectedOptionTrailingIcon(BuildContext context, {IconData iconData}) {
  if (iconData == null) {
    iconData = AdaptiveIcons.doneIconData;
  }

  return Icon(
    iconData,
    color: lightPrimaryDarkAccentColor(context),
  );
}
