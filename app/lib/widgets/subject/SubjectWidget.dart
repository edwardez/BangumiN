import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/subject/common/SubjectCommonActions.dart';
import 'package:munin/widgets/subject/mainpage/CharactersPreview.dart';
import 'package:munin/widgets/subject/mainpage/CommentsPreview.dart';
import 'package:munin/widgets/subject/mainpage/RelatedSubjectsPreview.dart';
import 'package:munin/widgets/subject/mainpage/SubjectCoverAndBasicInfo.dart';
import 'package:munin/widgets/subject/mainpage/SubjectRatingOverview.dart';
import 'package:munin/widgets/subject/mainpage/SubjectSummary.dart';
import 'package:munin/widgets/subject/management/SubjectManagementWidget.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class SubjectWidget extends StatelessWidget {
  final int subjectId;

  const SubjectWidget({Key key, @required this.subjectId})
      : assert(subjectId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> requestStatusFuture;

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, subjectId),
      distinct: true,
      onInit: (store) {
        if (store.state.subjectState.subjects[subjectId] == null) {
          final action = GetSubjectAction(subjectId: subjectId);
          store.dispatch(action);

          requestStatusFuture = action.completer.future;
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.subject == null) {
          return RequestInProgressIndicatorWidget(
            retryCallback: (_) {
              return vm.getSubject(context);
            },
            requestStatusFuture: requestStatusFuture,
          );
        }

        return _buildSubjectMainPage(
            context, vm.subject, vm.preferredSubjectInfoLanguage);
      },
    );
  }

  Widget _buildSubjectMainPage(BuildContext context, BangumiSubject subject,
      PreferredSubjectInfoLanguage preferredSubjectInfoLanguage) {
    List<Widget> widgets = [
      SubjectCoverAndBasicInfo(
          subject: subject,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage),
      SubjectRatingOverview(
        subject: subject,
      ),
      SubjectManagementWidget(subject: subject),
      SubjectSummary(subject: subject),
      if (!isIterableNullOrEmpty(subject.characters))
        CharactersPreview(subject: subject),
      if (!isBuiltListMultimapNullOrEmpty(subject.relatedSubjects))
        RelatedSubjectsPreview(
            subject: subject,
            preferredSubjectInfoLanguage: preferredSubjectInfoLanguage),
      CommentsPreview(subject: subject)
    ];

    return ScrollViewWithSliverAppBar(
      appBarMainTitle: Text('关于这${subject.type.quantifiedChineseNameByType}'),
      appBarSecondaryTitle: Text(
          preferredNameFromSubjectBase(subject, preferredSubjectInfoLanguage)),
      changeAppBarTitleOnScroll: true,
      nestedScrollViewBody: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: defaultDensePortraitHorizontalOffset,
          right: defaultDensePortraitHorizontalOffset,
          top: smallOffset,
          bottom: bottomOffset,
        ),
        itemBuilder: (BuildContext context, int index) => widgets[index],
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: widgets.length,
      ),
      safeAreaChildPadding: EdgeInsets.zero,
      enableBottomSafeArea: false,
      appBarActions: subjectCommonActions(context, subject),
    );
  }
}

class _ViewModel {
  final BangumiSubject subject;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final Future<void> Function(BuildContext context) getSubject;

  factory _ViewModel.fromStore(Store<AppState> store, int subjectId) {
    Future<void> _getSubject(BuildContext context) {
      if (store.state.subjectState.subjects.containsKey(subjectId)) {
        return null;
      }

      final action = GetSubjectAction(subjectId: subjectId);
      store.dispatch(action);
      return action.completer.future;
    }

    return _ViewModel(
        subject: store.state.subjectState.subjects[subjectId],
        getSubject: (BuildContext context) => _getSubject(context),
        preferredSubjectInfoLanguage: store
            .state.settingState.generalSetting.preferredSubjectInfoLanguage);
  }

  const _ViewModel({
    @required this.subject,
    @required this.getSubject,
    @required this.preferredSubjectInfoLanguage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          subject == other.subject &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage;

  @override
  int get hashCode => hash2(subject, preferredSubjectInfoLanguage);
}
