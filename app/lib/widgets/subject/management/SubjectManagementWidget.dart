import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/shared/button/MuninOutlineButton.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';

class SubjectManagementWidget extends StatelessWidget {
  final BangumiSubject subject;

  const SubjectManagementWidget({Key key, @required this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String collectionActionText =
        subject.userSubjectCollectionInfoPreview.status ==
                CollectionStatus.Pristine
            ? '加入'
            : '编辑';

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            if (subject.type == SubjectType.Anime ||
                subject.type == SubjectType.Real)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: MuninOutlineButton(
                    child: Text('查看章节'),
                    onPressed: () {
                      Application.router.navigateTo(
                        context,
                        Routes.subjectEpisodesRoute.replaceFirst(
                            RoutesVariable.subjectIdParam,
                            subject.id?.toString()),
                        transition: TransitionType.native,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: MuninOutlineButton(
                  child: Text('$collectionActionText收藏'),
                  onPressed: () {
                    showSnackBarOnSuccess(
                        context,
                        Application.router.navigateTo(
                          context,
                          Routes.subjectCollectionManagementRoute.replaceFirst(
                              RoutesVariable.subjectIdParam,
                              subject.id?.toString()),
                          transition: TransitionType.nativeModal,
                        ),
                        hasSuccessfullyUpdatedCollection
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
