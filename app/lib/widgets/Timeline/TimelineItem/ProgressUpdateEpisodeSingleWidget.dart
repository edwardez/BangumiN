import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/ProgressUpdateEpisodeSingle.dart';
import 'package:munin/widgets/shared/common/UserListTile.dart';

class ProgressUpdateEpisodeSingleWidget extends StatelessWidget {
  final ProgressUpdateEpisodeSingle progressUpdateEpisodeSingle;
  final int episodeNameMaxLines;
  final int subjectNameMaxLines;

  const ProgressUpdateEpisodeSingleWidget(
      {Key key,
      @required this.progressUpdateEpisodeSingle,
      this.episodeNameMaxLines = 2,
      this.subjectNameMaxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListTile.fromUser(user: progressUpdateEpisodeSingle.user),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: InkWell(
            child: Text(
              progressUpdateEpisodeSingle.episodeName,
              maxLines: episodeNameMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => {},
          ),
          subtitle: InkWell(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    progressUpdateEpisodeSingle.subjectName,
                    maxLines: subjectNameMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onTap: () => {},
          ),
        )
      ],
    );
  }
}
