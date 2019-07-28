import 'package:flutter/material.dart';
import 'package:munin/widgets/setting/Common.dart';

Icon buildTrailingIcon<T>(BuildContext context, T t1, T t2) {
  if (t1 == t2) {
    return selectedOptionTrailingIcon(context);
  } else {
    return null;
  }
}
