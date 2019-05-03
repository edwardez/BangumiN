import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/widgets/UserProfile/UserMoreDetails.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/strings.dart';

/// A few lines of introduction with a 'read more' button on the right
class UserIntroductionPreview extends StatelessWidget {
  static const introductionPreviewMaxLines = 2;

  /// A full profile is required  because this widget is also an entry point to
  /// More details widget which displays more details of this user
  final UserProfile profile;

  const UserIntroductionPreview({Key key, @required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget introPreviewWidget;
    if (isEmpty(profile.introductionElement.text)) {
      introPreviewWidget = WrappableText(
        '暂无简介',
        textStyle: Theme.of(context).textTheme.caption,
        fit: FlexFit.tight,
        maxLines: introductionPreviewMaxLines,
      );
    } else {
      introPreviewWidget = WrappableText(
        profile.introductionElement.text,
        fit: FlexFit.tight,
        maxLines: introductionPreviewMaxLines,
      );
    }

    return InkWell(
      child: Row(
        children: <Widget>[
          introPreviewWidget,
          Text(
            '详细资料',
            style: Theme.of(context).textTheme.caption,
          ),
          Icon(
            AdaptiveIcons.forwardIconData,
            color: Theme.of(context).textTheme.caption.color,
            size: Theme.of(context).textTheme.caption.fontSize,
          )
        ],
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return UserMoreDetails(profile: profile);
        }));
      },
    );
  }
}
