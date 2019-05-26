import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
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
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, subjectId),
      distinct: true,
      onInit: (store) {
        if (store.state.subjectState.subjects[subjectId] == null) {
          final action =
          GetSubjectAction(context: context, subjectId: subjectId);
          store.dispatch(action);
        }
      },
      onDispose: (store) {
        final action = CleanUpLoadingStatusAction(subjectId: subjectId);
        store.dispatch(action);
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.subject == null) {
          return RequestInProgressIndicatorWidget(
              loadingStatus: vm.subjectLoadingStatus,
              refreshAction:
              GetSubjectAction(context: context, subjectId: subjectId));
        }
        return _buildSubjectMainPage(
            context, vm.subject, vm.preferredSubjectInfoLanguage);
      },
    );
  }

  Widget _buildSubjectMainPage(BuildContext context, BangumiSubject subject,
      PreferredSubjectInfoLanguage preferredSubjectInfoLanguage) {
    List<Widget> widgets = [];
    widgets.add(SubjectCoverAndBasicInfo(
        subject: subject,
        preferredSubjectInfoLanguage: preferredSubjectInfoLanguage));

    widgets.add(SubjectRatingOverview(
      subject: subject,
    ));

    widgets.add(SubjectManagementWidget(subject: subject));

    widgets.add(SubjectSummary(subject: subject));

    if (!isIterableNullOrEmpty(subject.characters)) {
      widgets.add(CharactersPreview(subject: subject));
    }

    if (!isBuiltListMultimapNullOrEmpty(subject.relatedSubjects)) {
      widgets.add(RelatedSubjectsPreview(subject: subject,
          preferredSubjectInfoLanguage: preferredSubjectInfoLanguage));
    }

    // Adds a padding in the bottom so bottom comments are easier to read
    widgets.add(Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: CommentsPreview(subject: subject),
    ));

    return ScaffoldWithSliverAppBar(
      appBarMainTitle: Text('关于这${subject.type.quantifiedChineseNameByType}'),
      appBarSecondaryTitle:
      Text(preferredSubjectTitleFromSubjectBase(
          subject, preferredSubjectInfoLanguage)),
      changeAppBarTitleOnScroll: true,
      nestedScrollViewBody: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) => widgets[index],
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: widgets.length,
      ),
      safeAreaChildPadding: const EdgeInsets.only(
          left: defaultDensePortraitHorizontalPadding,
          right: defaultDensePortraitHorizontalPadding,
          top: largeVerticalPadding),
      enableBottomSafeArea: false,
      appBarActions: subjectCommonActions(context, subject),
    );
  }
}

class _ViewModel {
  final BangumiSubject subject;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final LoadingStatus subjectLoadingStatus;
  final Function(BuildContext context) getSubject;

  factory _ViewModel.fromStore(Store<AppState> store, int subjectId) {
    _getSubject(BuildContext context) {
      if (store.state.subjectState.subjects.containsKey(subjectId)) {
        return null;
      }

      final action = GetSubjectAction(context: context, subjectId: subjectId);
      store.dispatch(action);
    }

    return _ViewModel(
        subject: store.state.subjectState.subjects[subjectId],
        subjectLoadingStatus:
        store.state.subjectState.subjectsLoadingStatus[subjectId],
        getSubject: (BuildContext context) => _getSubject(context),
        preferredSubjectInfoLanguage: store
            .state.settingState.generalSetting.preferredSubjectInfoLanguage);
  }

  const _ViewModel({
    @required this.subject,
    @required this.subjectLoadingStatus,
    @required this.getSubject,
    @required this.preferredSubjectInfoLanguage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              subject == other.subject &&
              preferredSubjectInfoLanguage ==
                  other.preferredSubjectInfoLanguage &&
              subjectLoadingStatus == other.subjectLoadingStatus;

  @override
  int get hashCode =>
      hash3(subject,
          preferredSubjectInfoLanguage, subjectLoadingStatus);
}
