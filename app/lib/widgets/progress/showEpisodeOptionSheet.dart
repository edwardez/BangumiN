import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/progress/common/BaseEpisode.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/Divider.dart';
import 'package:munin/widgets/shared/utils/common.dart';

typedef OnUpdateEpisodeOptionTapped = Function(
  EpisodeUpdateType episodeUpdateType,
  BaseEpisode episode,
);

/// Shows a modal bottom sheet that contains possible episode options.
///
/// [episodeSubTitle] will be displayed under the episode main title.
/// After an episode update option is tapped, [onUpdateEpisodeOptionTapped] will
/// be called. Please note that it's the caller's responsibility to dismiss
/// modal bottom sheet after an episode update option is tapped(typically needs
/// to pop context).
showEpisodeOptionSheet({
  @required BuildContext context,
  @required BaseEpisode episode,
  @required String episodeSubTitle,
  @required PreferredSubjectInfoLanguage preferredSubjectInfoLanguage,
  @required OnUpdateEpisodeOptionTapped onUpdateEpisodeOptionTapped,
}) {
  Color buttonTextColor(EpisodeStatus status) {
    bool isCurrentUserEpisodeStatus = status == episode.userEpisodeStatus;

    if (isCurrentUserEpisodeStatus) {
      return lightPrimaryDarkAccentColor(context);
    }

    return null;
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Padding(
        padding: const EdgeInsets.only(
          top: defaultPortraitHorizontalOffset,
          left: defaultPortraitHorizontalOffset,
          right: defaultPortraitHorizontalOffset,
        ),
        child: ListView(
          children: <Widget>[
            Text(
              preferredName(
                  episode.name, episode.nameCn, preferredSubjectInfoLanguage),
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              episodeSubTitle,
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            onePixelHeightDivider(),
            ListTile(
              title: Center(
                child: Text('查看讨论', style: Theme.of(context).textTheme.body2),
              ),
              onTap: () {
                var callback = generateOnTapCallbackForBangumiContent(
                  contentType: BangumiContent.Episode,
                  context: context,
                  id: episode.id.toString(),
                );

                Navigator.of(context).pop();
                return callback();
              },
            ),
            onePixelHeightDivider(),
            ListTile(
              title: Center(
                child: Text(
                  '看过',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: buttonTextColor(EpisodeStatus.Collect)),
                ),
              ),
              onTap: () {
                onUpdateEpisodeOptionTapped(
                  EpisodeUpdateType.Collect,
                  episode,
                );
              },
            ),

            /// Only regular episode can be used for 'watch until'
            /// this is undocumented but it matches bangumi website behavior
            /// and use non-regular episode for `watch until` simply doesn't work
            /// https://github.com/bangumi/api/issues/32
            if (episode.episodeType == EpisodeType.Regular) ...[
              onePixelHeightDivider(),
              ListTile(
                title: Center(
                  child: Text('看到', style: Theme.of(context).textTheme.body2),
                ),
                onTap: () {
                  onUpdateEpisodeOptionTapped(
                    EpisodeUpdateType.CollectUntil,
                    episode,
                  );
                },
              ),
            ],
            onePixelHeightDivider(),
            ListTile(
              title: Center(
                child: Text(
                  '想看',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: buttonTextColor(EpisodeStatus.Wish)),
                ),
              ),
              onTap: () {
                onUpdateEpisodeOptionTapped(
                  EpisodeUpdateType.Wish,
                  episode,
                );
              },
            ),
            onePixelHeightDivider(),
            ListTile(
              title: Center(
                child: Text(
                  '抛弃',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: buttonTextColor(EpisodeStatus.Dropped)),
                ),
              ),
              onTap: () {
                onUpdateEpisodeOptionTapped(
                  EpisodeUpdateType.Dropped,
                  episode,
                );
              },
            ),
            if (episode.userEpisodeStatus != EpisodeStatus.Untouched) ...[
              onePixelHeightDivider(),
              ListTile(
                title: Center(
                  child: Text(
                    '撤销',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                onTap: () {
                  onUpdateEpisodeOptionTapped(
                    EpisodeUpdateType.Remove,
                    episode,
                  );
                },
              ),
            ],
          ],
        ),
      );
    },
  );
}
