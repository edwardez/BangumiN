import 'package:flutter/material.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

/// A common style for 'more actions' entry on subject page.
///
/// It's simply a wrapper around [InkWell] to ensure a minimum vertical padding.
class SubjectMoreItemsEntry extends StatelessWidget {
  final GestureTapCallback onTap;

  final String moreItemsText;

  const SubjectMoreItemsEntry(
      {Key key, @required this.onTap, @required this.moreItemsText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: smallOffset),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: smallOffset,
          ),
          child: Row(
            children: <Widget>[
              WrappableText(
                moreItemsText,
                fit: FlexFit.tight,
              ),
              Icon(
                AdaptiveIcons.forwardIconData,
                color: lightPrimaryDarkAccentColor(context),
              )
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
