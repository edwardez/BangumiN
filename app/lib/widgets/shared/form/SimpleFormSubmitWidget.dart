import 'package:flutter/material.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';

class SimpleFormSubmitWidget extends StatelessWidget {
  final bool canSubmit;
  final LoadingStatus loadingStatus;
  final Future Function(BuildContext context) onSubmitPressed;

  const SimpleFormSubmitWidget(
      {Key key,
      @required this.canSubmit,
      @required this.loadingStatus,
      @required this.onSubmitPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingStatus == LoadingStatus.Loading) {
      return AdaptiveProgressIndicator(
        indicatorStyle: IndicatorStyle.Material,
      );
    }

    return FlatButton(
        onPressed: canSubmit
            ? () {
                onSubmitPressed(context);
              }
            : null,
        textColor: lightPrimaryDarkAccentColor(context),
        child: Text('发表'));
  }
}
