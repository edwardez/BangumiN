import 'package:flutter/material.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';

class SimpleFormSubmitWidget extends StatelessWidget {
  final bool canSubmit;
  final RequestStatus loadingStatus;
  final Future Function(BuildContext context) onSubmitPressed;

  final String submitButtonText;

  const SimpleFormSubmitWidget({
    Key key,
    @required this.canSubmit,
    @required this.loadingStatus,
    @required this.onSubmitPressed,
    this.submitButtonText = '发表',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingStatus == RequestStatus.Loading) {
      return MuninPadding.noVerticalOffset(
        denseHorizontal: true,
        child: AdaptiveProgressIndicator(
          indicatorStyle: IndicatorStyle.Material,
        ),
      );
    }

    return TextButton(
        onPressed: canSubmit
            ? () {
                onSubmitPressed(context);
              }
            : null,
        style: TextButton.styleFrom(
          foregroundColor: lightPrimaryDarkAccentColor(context),
        ),
        child: Text(submitButtonText));
  }
}
