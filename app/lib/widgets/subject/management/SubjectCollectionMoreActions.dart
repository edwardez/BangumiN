import 'dart:async';

import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/icons/AdaptiveIcons.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionDeletionWidget.dart';

/// Additional actions for a subject collection.
///
/// Note: If this widget is inserted under some new route, remember to update
/// route pop logic in [SubjectCollectionDeletionWidget], otherwise there might be unexpected consequence.
class SubjectCollectionMoreActions extends StatelessWidget {
  final BangumiSubject subject;

  final Future<void> Function(BangumiSubject subject) deleteCollectionCallback;

  const SubjectCollectionMoreActions({
    Key key,
    @required this.subject,
    @required this.deleteCollectionCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showMinHeightModalBottomSheet(
          context,
          [
            SubjectCollectionDeletionWidget(
              deleteCollectionCallback: deleteCollectionCallback,
              subject: subject,
              outerScaffoldContext: context,
            ),
          ],
        );
      },
      icon: Icon(AdaptiveIcons.moreActionsIconData),
    );
  }
}
