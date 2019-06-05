import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';
import 'package:munin/widgets/shared/utils/common.dart';

class SubjectCoverTitleTile extends StatelessWidget {
  final String imageUrl;

  /// Id of the subject
  final int id;

  /// Name of the subject
  final String name;

  const SubjectCoverTitleTile(
      {Key key,
      @required this.imageUrl,
      @required this.id,
      @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: MuninPadding(
        child: Row(
          children: <Widget>[
            CachedRoundedCover.asGridSize(
              imageUrl: imageUrl ?? bangumiTextOnlySubjectCover,
            ),
            Padding(
              padding: EdgeInsets.only(left: mediumOffset),
            ),
            Flexible(
              child: Text(name),
            )
          ],
        ),
      ),
      onTap: () {
        if (id == null) {
          return null;
        }

        return generateOnTapCallbackForBangumiContent(
            contentType: BangumiContent.Subject,
            id: id.toString(),
            context: context)();
      },
    );
  }
}
