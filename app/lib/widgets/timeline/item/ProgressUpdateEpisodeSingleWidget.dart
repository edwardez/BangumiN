import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/ProgressUpdateEpisodeSingle.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/UserActionTile.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/timeline/item/common/FeedMoreActionsMenu.dart';
import 'package:munin/widgets/timeline/item/common/FeedTile.dart';

class ProgressUpdateEpisodeSingleWidget extends StatelessWidget {
  final ProgressUpdateEpisodeSingle progressUpdateEpisodeSingle;
  final int episodeNameMaxLines;
  final int subjectNameMaxLines;
  final DeleteFeedCallback onDeleteFeed;

  const ProgressUpdateEpisodeSingleWidget(
      {Key key,
      @required this.progressUpdateEpisodeSingle,
      @required this.onDeleteFeed,
      this.episodeNameMaxLines = 2,
      this.subjectNameMaxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListTile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UserActionTile.fromUser(
          user: progressUpdateEpisodeSingle.user,
          trailing:
          buildTrailingWidget(progressUpdateEpisodeSingle, onDeleteFeed),
        ),
        Padding(
          padding: EdgeInsets.only(top: smallOffset),
          child: InkWell(
            child: Text(
              progressUpdateEpisodeSingle.episodeName,
              maxLines: episodeNameMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: generateOnTapCallbackForBangumiContent(
                contentType: BangumiContent.Episode,
                id: progressUpdateEpisodeSingle.episodeId,
                context: context),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: smallOffset),
          child: InkWell(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    progressUpdateEpisodeSingle.subjectName,
                    style: captionTextWithBody1Size(context),
                    maxLines: subjectNameMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: generateOnTapCallbackForBangumiContent(
                contentType: BangumiContent.Subject,
                id: progressUpdateEpisodeSingle.subjectId,
                context: context),
          ),
        ),
      ],
    );
  }
}
