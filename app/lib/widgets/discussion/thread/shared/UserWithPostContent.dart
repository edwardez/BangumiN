import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/common/BangumiUserBasic.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

/// A widget that contains an user avatar and post content.
class UserWithPostContent extends StatelessWidget {
  static const double avatarRadius = 15.0;

  final BangumiUserBasic author;

  /// Post content in html.
  final String contentHtml;

  /// Whether to reveal all spoilers in the content.
  final bool showSpoiler;

  /// A trailing string after the user name, it put on the second row under the
  /// user nick name.
  final String trailingStringAfterUsername;

  /// Whether to align post content with avatar, if set to false, it aligns with
  /// user nickname.
  final bool alignPostContentWithAvatar;

  final bool attachTopDivider;

  final GestureTapCallback onTapMoreActionsIcon;

  const UserWithPostContent(
      {Key key,
      @required this.author,
      @required this.trailingStringAfterUsername,
      @required this.alignPostContentWithAvatar,
      @required this.contentHtml,
      @required this.showSpoiler,
      @required this.onTapMoreActionsIcon,
      @required this.attachTopDivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (attachTopDivider) Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedCircleAvatar(
              imageUrl: author?.avatar?.common,
              navigateToUserRouteOnTap: true,
              username: author.username,
              radius: avatarRadius,
            ),
            Padding(
              padding: EdgeInsets.only(left: baseOffset),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrappableText(
                        author.nickname,
                        fit: FlexFit.tight,
                      ),
                      InkWell(
                          child: Icon(
                            AdaptiveIcons.moreActionsIconData,
                            color: Theme.of(context).unselectedWidgetColor,
                          ),
                          onTap: () {
                            onTapMoreActionsIcon();
                          },
                          borderRadius: BorderRadius.circular(defaultIconSize)),
                    ],
                  ),
                  WrappableText(trailingStringAfterUsername,
                      outerWrapper: OuterWrapper.Row,
                      textStyle: defaultCaptionText(context)),
                  if (!alignPostContentWithAvatar) ...[
                    Padding(
                      padding: EdgeInsets.only(top: baseOffset),
                    ),
                    BangumiHtml(
                      html: contentHtml,
                      showSpoiler: showSpoiler,
                    )
                  ]
                ],
              ),
            )
          ],
        ),
        if (alignPostContentWithAvatar) ...[
          Padding(
            padding: EdgeInsets.only(top: baseOffset),
          ),
          BangumiHtml(
            html: contentHtml,
            showSpoiler: showSpoiler,
          )
        ]
      ],
    );
  }
}
