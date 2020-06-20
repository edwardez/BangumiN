import 'package:flutter/material.dart';
import 'package:munin/widgets/setting/Common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

Icon buildTrailingIcon<T>(BuildContext context, T t1, T t2,
    {IconData iconData = OMIcons.done}) {
  if (t1 == t2) {
    return selectedOptionTrailingIcon(context, iconData: iconData);
  } else {
    return null;
  }
}
