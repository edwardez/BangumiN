import 'dart:math' as math;

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeType.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Colors.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/button/customization.dart';
import 'package:munin/widgets/shared/common/Divider.dart';
import 'package:munin/widgets/shared/cover/ClickableCachedRoundedCover.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class InProgressAnimeOrRealWidget extends StatelessWidget {
  final InProgressAnimeOrRealCollection subject;
  final void Function(EpisodeUpdateType episodeUpdateType, int episodeId,
      double newEpisodeNumber) onUpdateSingleEpisode;
  final void Function(int episodeSequentialNumber) onUpdateBatchEpisodes;

  const InProgressAnimeOrRealWidget({
    Key key,
    @required this.subject,
    @required this.onUpdateSingleEpisode,
    @required this.onUpdateBatchEpisodes,
  }) : super(key: key);

  _showEpisodeSheet(BuildContext context, EpisodeProgress episode) {
    Color buttonTextColor(EpisodeStatus status) {
      bool isSelected = status == episode.userEpisodeStatus;

      if (isSelected) {
        return lightPrimaryDarkAccentColor(context);
      }

      return null;
    }

    String buildSubtitle() {
      List<String> subtitles = [];
      if (isNotEmpty(episode.nameCn)) {
        subtitles.add(episode.nameCn);
      }

      if (isNotEmpty(episode.duration)) {
        subtitles.add('时长:${episode.duration}');
      }

      if (isNotEmpty(episode.airDate)) {
        subtitles.add('首播:${episode.airDate}');
      }

      return subtitles.join(' / ');
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.only(
              top: defaultPortraitHorizontalPadding,
              left: defaultPortraitHorizontalPadding,
              right: defaultPortraitHorizontalPadding,
            ),
            child: ListView(
              children: <Widget>[
                Text(
                  episode.name,
                  style: Theme.of(context).textTheme.title,
                ),
                Text(
                  buildSubtitle(),
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                onePixelHeightDivider(),
                ListTile(
                  title: Center(
                    child:
                        Text('查看讨论', style: Theme.of(context).textTheme.body2),
                  ),
                  onTap: () {
                    launch('https://bgm.tv/ep/${episode.id}',
                        forceSafariVC: true);
                    Navigator.of(context).pop();
                  },
                ),
                onePixelHeightDivider(),
                ListTile(
                  title: Center(
                    child: Text(
                      '看过',
                      style: Theme.of(context).textTheme.body2.copyWith(
                          color: buttonTextColor(EpisodeStatus.Collect)),
                    ),
                  ),
                  onTap: episode.userEpisodeStatus == EpisodeStatus.Collect
                      ? null
                      : () {
                          onUpdateSingleEpisode(EpisodeUpdateType.Collect,
                              episode.id, episode.sequentialNumber);
                          Navigator.of(context).pop();
                        },
                ),

                /// Only regular episode can be used for 'watch until'
                /// this is undocumented but it matches bangumi website behavior
                /// and use non-regular episode for `watch until` simply doesn't work
                /// https://github.com/bangumi/api/issues/32
                if (episode.episodeType == EpisodeType.RegularEpisode) ...[
                  onePixelHeightDivider(),
                  ListTile(
                    title: Center(
                      child:
                          Text('看到', style: Theme.of(context).textTheme.body2),
                    ),
                    onTap: () {
                      onUpdateBatchEpisodes(episode.sequentialNumber.toInt());
                      Navigator.of(context).pop();
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
                  onTap: episode.userEpisodeStatus == EpisodeStatus.Wish
                      ? null
                      : () {
                          onUpdateSingleEpisode(EpisodeUpdateType.Wish,
                              episode.id, episode.sequentialNumber);
                          Navigator.of(context).pop();
                        },
                ),
                onePixelHeightDivider(),
                ListTile(
                  title: Center(
                    child: Text(
                      '抛弃',
                      style: Theme.of(context).textTheme.body2.copyWith(
                          color: buttonTextColor(EpisodeStatus.Dropped)),
                    ),
                  ),
                  onTap: episode.userEpisodeStatus == EpisodeStatus.Dropped
                      ? null
                      : () {
                          onUpdateSingleEpisode(EpisodeUpdateType.Dropped,
                              episode.id, episode.sequentialNumber);
                          Navigator.of(context).pop();
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
                      onUpdateSingleEpisode(EpisodeUpdateType.Remove,
                          episode.id, episode.sequentialNumber);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ],
            ),
          );
        });
  }

  Color episodeChipColor(BuildContext context, EpisodeStatus status) {
    switch (status) {
      case EpisodeStatus.Wish:
        return Theme
            .of(context)
            .brightness == Brightness.dark ? bangumiPink.shade200 : Theme
            .of(context)
            .accentColor;
      case EpisodeStatus.Dropped:
        return Theme.of(context).unselectedWidgetColor;
      case EpisodeStatus.Collect:
        return lightPrimaryDarkAccentColor(context);
      default:
        return Theme.of(context).unselectedWidgetColor;
    }
  }

  List<Widget> _buildEpisodeChips(
      BuildContext context, InProgressAnimeOrRealCollection subject) {
    List<Widget> chips = [];
    for (EpisodeProgress episode in subject.episodes.values) {
      chips.add(Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: ActionChip(
          onPressed: () {
            _showEpisodeSheet(context, episode);
          },
          backgroundColor: Colors.transparent,
          shape: StadiumBorder(
              side: BorderSide(
                  color: episodeChipColor(context, episode.userEpisodeStatus))),
          label: Text(
            '${tryFormatDoubleAsInt(episode.sequentialNumber)}',
            style: Theme.of(context).textTheme.body1.copyWith(
                decoration: episode.userEpisodeStatus == EpisodeStatus.Dropped
                    ? TextDecoration.lineThrough
                    : null,
                color: episodeChipColor(context, episode.userEpisodeStatus)),
          ),
        ),
      ));
    }

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    assert(defaultPortraitHorizontalPadding -
            defaultDensePortraitHorizontalPadding ==
        8.0);

    return ExpansionTile(
      key: PageStorageKey<String>('progress-${subject.subject.id}'),
      title: Padding(
        /// HACK: ListTile has a default of `EdgeInsets.symmetric(horizontal: 16.0)`
        /// padding, we want a 24.0 padding by default so adding a offset here
        padding: EdgeInsets.symmetric(
            horizontal: math.max(
                0,
                defaultPortraitHorizontalPadding -
                    defaultDensePortraitHorizontalPadding)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                ClickableCachedRoundedCover(
                  width: 48,
                  imageUrl: subject.subject?.images?.large ??
                      bangumiTextOnlySubjectCover,
                  height: 48,
                  contentType: BangumiContent.Subject,
                  id: subject.subject.id.toString(),
                ),
                ButtonTheme.fromButtonThemeData(
                  data: smallButtonTheme(context),
                  child: OutlineButton(
                    onPressed: () {
                      Application.router.navigateTo(
                          context,
                          Routes.subjectCollectionManagementRoute.replaceFirst(
                              ':subjectId', subject.subject.id.toString()),
                          transition: TransitionType.nativeModal);
                    },
                    child: Text("编辑"),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(child: Text(subject.subject.name)),
                    ],
                  ),
                  WrappableText(
                    '${subject.completedEpisodesCount ?? '??'}/${subject.subject.totalEpisodesCount ?? '??'}话',
                    textStyle: Theme.of(context).textTheme.caption,
                    outerWrapper: OuterWrapper.Row,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPortraitHorizontalPadding),
            child: Wrap(
              children: _buildEpisodeChips(context, subject),
            ),
          ),
        ),
      ],
    );
  }
}
