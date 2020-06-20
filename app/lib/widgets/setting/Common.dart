import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

Icon selectedOptionTrailingIcon(BuildContext context,
    {IconData iconData = OMIcons.done}) {
  return Icon(
    iconData,
    color: lightPrimaryDarkAccentColor(context),
  );
}
