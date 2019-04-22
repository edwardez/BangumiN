import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  /// 14.0 is taken from [CupertinoSliverRefreshControl.buildSimpleRefreshIndicator]
  static const defaultIndicatorRadius = 14.0;
  static const defaultMaterialIndicatorStrokeWidth = 2.0;

  final double indicatorRadius;

  final double materialIndicatorStrokeWidth;

  const AdaptiveProgressIndicator(
      {Key key,
      this.indicatorRadius = defaultIndicatorRadius,
      this.materialIndicatorStrokeWidth = defaultMaterialIndicatorStrokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        radius: defaultIndicatorRadius,
      );
    }

    return IconButton(
      icon: SizedBox(
        width: defaultIndicatorRadius * 2,
        height: defaultIndicatorRadius * 2,
        child: CircularProgressIndicator(
          strokeWidth: defaultMaterialIndicatorStrokeWidth,
        ),
      ),
      onPressed: null,
    );
  }
}
