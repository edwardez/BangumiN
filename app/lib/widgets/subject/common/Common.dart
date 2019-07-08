import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';

String collectionActionText(BangumiSubject subject) =>
    subject.userSubjectCollectionInfoPreview.status == CollectionStatus.Pristine
        ? '加入收藏'
        : '编辑收藏';

void navigateToSubjectCollection(BuildContext context, BangumiSubject subject) {
  showSnackBarOnSuccess(
      context,
      Application.router.navigateTo(
        context,
        Routes.subjectCollectionManagementRoute.replaceFirst(
            RoutesVariable.subjectIdParam, subject.id?.toString()),
        transition: TransitionType.nativeModal,
      ),
      hasSuccessfullyUpdatedCollection);
}
