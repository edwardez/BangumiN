import 'dart:async';

import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionDeletionWaitingDialog.dart';

/// Delete collection widget.
///
/// Note: If this widget is inserted under some new route, remember to update
/// route pop logic in the code, otherwise there might be unexpected consequence.
class SubjectCollectionDeletionWidget extends StatefulWidget {
  final BangumiSubject subject;

  final Future<void> Function(BangumiSubject subject) deleteCollectionCallback;

  /// An optional outerScaffoldContext, it can be used to show snackbar
  /// if [SubjectCollectionDeletionWidget] is placed in a place where there is
  /// no scaffold.
  final BuildContext outerScaffoldContext;

  const SubjectCollectionDeletionWidget({
    Key key,
    @required this.subject,
    @required this.deleteCollectionCallback,
    this.outerScaffoldContext,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectCollectionDeletionWidgetState();
  }
}

class _SubjectCollectionDeletionWidgetState
    extends State<SubjectCollectionDeletionWidget> {
  /// Pops until collection dialog is closed.
  ///
  /// Widget needs to be mounted in order to pop.
  _popUntilCollectionDialogIsClosed(BuildContext context) {
    if (!mounted) {
      return;
    }

    String subjectManagementRoute = Routes.subjectCollectionManagementRoute
        .replaceAll(
        RoutesVariable.subjectIdParam, widget.subject.id.toString());

    String lastUnPoppedRoute;
    Navigator.popUntil(context, (route) {
      // Note that anonymous route might be null.
      final routeName = route.settings.name;

      // until we've reached entry point of subject collection
      // or first route of the app.
      if (routeName == subjectManagementRoute ||
          routeName == Routes.root ||
          route.isFirst) {
        lastUnPoppedRoute = routeName;
        return true;
      }

      // pops all other routes.
      return false;
    });

    /// If last un-popped route is subject management route and we can still pop,
    /// then pop it.
    if (lastUnPoppedRoute == subjectManagementRoute &&
        Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  /// Pops context until we reach collection dialog
  ///
  /// Widget needs to be mounted in order to pop.
  /// Theoretically, at most one context needs to be popped(delete operation
  /// dialog).
  _popUntilCollectionDialog(BuildContext context) {
    if (!mounted) {
      return;
    }

    const maxRouteCountUntilReachTarget = 2;

    int routesToCloseCount = 0;

    String subjectCollectionManagementRoute =
        Routes.subjectCollectionManagementRoute.replaceAll(
            RoutesVariable.subjectIdParam, widget.subject.id.toString());

    Navigator.popUntil(context, (route) {
      routesToCloseCount++;

      // Note that anonymous route might be null.
      final routeName = route.settings.name;

      // until we've reached entry point of subject collection
      // or first route of the app or more than [maxCloseableRoute] number of
      // routes have been popped.
      if (routeName == subjectCollectionManagementRoute ||
          route.isFirst ||
          routesToCloseCount > maxRouteCountUntilReachTarget) {
        return true;
      }

      assert(routesToCloseCount <= maxRouteCountUntilReachTarget);
      // pops all other routes.
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('删除收藏'),
      onTap: () async {
        bool confirmDeletion = await showMuninConfirmActionDialog(
          context,
          title: '确认删除收藏？',
          dialogBody: '将从Bangumi上删除这部作品的收藏，此操作不可逆。',
          confirmActionText: '确认删除',
          cancelActionText: '放弃',
        );
        if (confirmDeletion) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return SubjectCollectionDeletionWaitingDialog();
            },
          );

          try {
            await widget.deleteCollectionCallback(widget.subject);

            _popUntilCollectionDialogIsClosed(context);
          } catch (error) {
            Scaffold.of(widget.outerScaffoldContext ?? context)
                .showSnackBar(SnackBar(
              content: Text('删除收藏失败'),
            ));
            _popUntilCollectionDialog(context);
          }
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
