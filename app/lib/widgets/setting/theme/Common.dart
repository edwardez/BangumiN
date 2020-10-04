import 'package:flutter/material.dart';
import 'package:munin/widgets/setting/Common.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';

Icon buildTrailingIcon<T>(BuildContext context, T t1, T t2,
    {IconData iconData}) {
  if (iconData == null) {
    iconData = AdaptiveIcons.doneIconData;
  }
  if (t1 == t2) {
    return selectedOptionTrailingIcon(context, iconData: iconData);
  } else {
    return null;
  }
}
