
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';

enum IndicatorStyle {
  Material,
  Cupertino,
  Adaptive,

  /// currently not in use
  Fuchsia,
}

class AdaptiveProgressIndicator extends StatelessWidget {
  /// 14.0 is taken from [CupertinoSliverRefreshControl.buildSimpleRefreshIndicator]
  static const defaultIndicatorRadius = 14.0;
  static const defaultMaterialIndicatorStrokeWidth = 2.0;

  final double indicatorRadius;

  final double materialIndicatorStrokeWidth;

  final IndicatorStyle indicatorStyle;

  const AdaptiveProgressIndicator(
      {Key key,
      this.indicatorRadius = defaultIndicatorRadius,
      this.materialIndicatorStrokeWidth = defaultMaterialIndicatorStrokeWidth,
      this.indicatorStyle = IndicatorStyle.Adaptive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cupertinoIndicator = CupertinoActivityIndicator(
      radius: defaultIndicatorRadius,
    );

    Widget materialIndicator = IconButton(
      icon: SizedBox(
        width: defaultIndicatorRadius * 2,
        height: defaultIndicatorRadius * 2,
        child: CircularProgressIndicator(
          strokeWidth: defaultMaterialIndicatorStrokeWidth,
        ),
      ),
      onPressed: null,
    );

    if (indicatorStyle == IndicatorStyle.Cupertino) {
      return cupertinoIndicator;
    }

    if (indicatorStyle == IndicatorStyle.Material) {
      return materialIndicator;
    }

    if (isCupertinoPlatform()) {
      return cupertinoIndicator;
    }

    return materialIndicator;
  }
}
