import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/widgets/subject/share/SubjectReviewShare.dart';

const generateCommentShareCardText = '生成评价分享卡片';

showMoreActionsForReview({
  @required BuildContext context,
  @required BangumiSubject subject,
  @required SubjectReview review,
}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  title: Text(generateCommentShareCardText),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubjectReviewShare(
                                subject: subject,
                                review: review,
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      });
}
