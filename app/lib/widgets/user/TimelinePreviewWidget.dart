import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/timeline/TimelinePreview.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/timeline/Timeline.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TimelinePreviewWidget extends StatelessWidget {
  final UserProfile profile;
  final bool isCurrentAppUser;

  const TimelinePreviewWidget(
      {Key key, @required this.profile, @required this.isCurrentAppUser})
      : super(key: key);

  RichText _buildFeed(BuildContext context, TimelinePreview previewFeed) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '•  ${previewFeed.content}',
            style: Theme.of(context).textTheme.body1),
        TextSpan(
            text:
                ' ${TimeUtils.formatMilliSecondsEpochTime(previewFeed.userUpdatedAt, displayTimeIn: DisplayTimeIn.AlwaysRelative)}',
            style: Theme.of(context).textTheme.caption),
      ]),
    );
  }

  _buildFloatingComposeMessageButton(BuildContext context, String username) {
    /// Show floating button only if user is on its own profile widget
    if (!isCurrentAppUser) {
      return null;
    }

    return FloatingActionButton(
      tooltip: '发表新吐槽',
      child: Icon(OMIcons.add),
      onPressed: () {
        Application.router.navigateTo(
            context,
            Routes.composeTimelineMessageRoute
                .replaceAll(RoutesVariable.usernameParam, username),
            transition: TransitionType.nativeModal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              WrappableText(
                '时间胶囊',
                fit: FlexFit.tight,
                textStyle: Theme.of(context).textTheme.subhead,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  AdaptiveIcons.forwardIconData,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (TimelinePreview preview in profile.timelinePreviews)
                _buildFeed(context, preview)
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: MuninTimeline.onUserProfile(
                    username: profile.basicInfo.username,
                  ),
                  floatingActionButton: _buildFloatingComposeMessageButton(
                      context, profile.basicInfo.username),
                ),
            settings: RouteSettings(
                name: Routes.userProfileTimelineRoute
                    .replaceAll(':username', profile.basicInfo.username)),
          ),
        );
      },
    );
  }
}
