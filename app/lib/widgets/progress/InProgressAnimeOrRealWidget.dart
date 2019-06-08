import 'dart:math' as math;

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/progress/api/EpisodeProgress.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/common/BaseEpisode.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/progress/showEpisodeOptionSheet.dart';
import 'package:munin/widgets/shared/button/customization.dart';
import 'package:munin/widgets/shared/cover/ClickableCachedRoundedCover.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';

class InProgressAnimeOrRealWidget extends StatelessWidget {
  final InProgressAnimeOrRealCollection collection;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final bool expandAllProgressTiles;

  final void Function(EpisodeUpdateType episodeUpdateType, int episodeId,
      double newEpisodeNumber) onUpdateSingleEpisode;
  final void Function(int episodeSequentialNumber) onUpdateBatchEpisodes;

  const InProgressAnimeOrRealWidget({
    Key key,
    @required this.collection,
    @required this.preferredSubjectInfoLanguage,
    @required this.onUpdateSingleEpisode,
    @required this.onUpdateBatchEpisodes,
    @required this.expandAllProgressTiles,
  }) : super(key: key);

  String buildEpisodeSubtitle(EpisodeProgress episode) {
    List<String> subtitles = [];
    Optional<String> maybeSecondaryTitle = secondarySubjectTitle(
        episode.name, episode.nameCn, preferredSubjectInfoLanguage);
    if (maybeSecondaryTitle.isPresent) {
      subtitles.add(maybeSecondaryTitle.value);
    }

    if (isNotEmpty(episode.duration)) {
      subtitles.add('时长:${episode.duration}');
    }

    if (isNotEmpty(episode.airDate)) {
      subtitles.add('首播:${episode.airDate}');
    }

    return subtitles.join(' / ');
  }

  List<Widget> _buildEpisodeChips(
      BuildContext context, InProgressAnimeOrRealCollection subject) {
    List<Widget> chips = [];
    for (EpisodeProgress episode in subject.episodes.values) {
      final episodeColor =
      EpisodeStatus.getColor(context, episode.userEpisodeStatus);

      chips.add(Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: ActionChip(
          onPressed: () {
            showEpisodeOptionSheet(
              context: context,
              episodeSubTitle: buildEpisodeSubtitle(episode),
              preferredSubjectInfoLanguage: preferredSubjectInfoLanguage,
              episode: episode,
              onUpdateEpisodeOptionTapped: (EpisodeUpdateType episodeUpdateType,
                  BaseEpisode baseEpisode,) {
                // Whatever the outcome is, dismiss bottom sheet first.
                Navigator.of(context).pop();

                // Batch update always works.
                if (episodeUpdateType == EpisodeUpdateType.CollectUntil) {
                  onUpdateBatchEpisodes(episode.sequentialNumber.toInt());
                  return;
                }

                // For single update, if action results the same outcome as
                // current, do nothing.
                if (episodeUpdateType.destinationEpisodeStatus ==
                    baseEpisode.userEpisodeStatus
                ) {
                  return;
                }

                // Otherwise, update relevant episode.
                onUpdateSingleEpisode(episodeUpdateType,
                    episode.id, episode.sequentialNumber);
              },
            );
          },
          backgroundColor: Colors.transparent,
          shape: StadiumBorder(
              side: BorderSide(
                color: episodeColor,
              )),
          label: Text(
            '${tryFormatDoubleAsInt(episode.sequentialNumber)}',
            style: Theme.of(context).textTheme.body1.copyWith(
                decoration: episode.userEpisodeStatus == EpisodeStatus.Dropped
                    ? TextDecoration.lineThrough
                    : null,
                color: episodeColor),
          ),
        ),
      ));
    }

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    assert(defaultPortraitHorizontalOffset -
        defaultDensePortraitHorizontalOffset ==
        8.0);

    return ExpansionTile(
      key: PageStorageKey<String>('progress-${collection.subject.id}'),
      initiallyExpanded: expandAllProgressTiles,
      title: Padding(
        /// HACK: ListTile has a default of `EdgeInsets.symmetric(horizontal: 16.0)`
        /// padding, we want a 24.0 padding by default so adding a offset here
        padding: EdgeInsets.symmetric(
            horizontal: math.max(
                0,
                defaultPortraitHorizontalOffset -
                    defaultDensePortraitHorizontalOffset)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                ClickableCachedRoundedCover(
                  width: 48,
                  imageUrl: collection.subject?.cover?.large ??
                      bangumiTextOnlySubjectCover,
                  height: 48,
                  contentType: BangumiContent.Subject,
                  id: collection.subject.id.toString(),
                ),
                ButtonTheme.fromButtonThemeData(
                  data: smallButtonTheme(context),
                  child: OutlineButton(
                    onPressed: () {
                      Application.router.navigateTo(
                          context,
                          Routes.subjectCollectionManagementRoute.replaceFirst(
                              ':subjectId', collection.subject.id.toString()),
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
                      Flexible(
                          child: Text(preferredSubjectTitleFromSubjectBase(
                              collection.subject,
                              preferredSubjectInfoLanguage))),
                    ],
                  ),
                  WrappableText(
                    '${collection.completedEpisodesCount ?? '??'}/${collection
                        .subject.totalEpisodesCount ?? '??'}话',
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
                horizontal: defaultPortraitHorizontalOffset),
            child: Wrap(
              children: _buildEpisodeChips(context, collection),
            ),
          ),
        ),
      ],
    );
  }
}
