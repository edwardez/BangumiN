import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:munin/widgets/subject/MainPage/CharactersPreview.dart';
import 'package:munin/widgets/subject/MainPage/CommentsPreview.dart';
import 'package:munin/widgets/subject/MainPage/RelatedSubjectsPreview.dart';
import 'package:munin/widgets/subject/MainPage/SubjectCoverAndBasicInfo.dart';
import 'package:munin/widgets/subject/MainPage/SubjectSummary.dart';
import 'package:munin/widgets/subject/common/SubjectCommonActions.dart';
import 'package:munin/widgets/subject/management/SubjectManagementWidget.dart';
import 'package:redux/redux.dart';

class SubjectWidget extends StatelessWidget {
  final int subjectId;

  const SubjectWidget({Key key, @required this.subjectId})
      : assert(subjectId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store),
      distinct: true,
      onInit: (store) {
        if (store.state.subjectState.subjects[subjectId] == null) {
          final action =
          GetSubjectAction(context: context, subjectId: subjectId);
          store.dispatch(action);
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        /// TODO: write a generic widget to handle malformed parameter case like subjectId == null
        if (vm.subjectState.subjects[subjectId] == null) {
          return ScaffoldWithRegularAppBar(
            appBar: AppBar(
              title: Text('加载中'),
            ),
            safeAreaChild: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return _buildSubjectMainPage(
            context, vm.subjectState.subjects[subjectId]);
      },
    );
  }

  Widget _buildSubjectMainPage(BuildContext context, Subject subject) {
    List<Widget> widgets = [];
    widgets.add(SubjectCoverAndBasicInfo(
      subject: subject,
    ));

    widgets.add(SubjectManagementWidget(subject: subject));

    widgets.add(SubjectSummary(subject: subject));

    if (!isIterableNullOrEmpty(subject.characters)) {
      widgets.add(CharactersPreview(subject: subject));
    }

    if (!isBuiltListMultimapNullOrEmpty(subject.relatedSubjects)) {
      widgets.add(RelatedSubjectsPreview(subject: subject));
    }

    widgets.add(CommentsPreview(subject: subject));

    return ScaffoldWithSliverAppBar(
      appBarMainTitle: '关于这${subject.type.quantifiedChineseNameByType}',
      appBarSecondaryTitle: subject.name,
      changeAppBarTitleOnScroll: true,
      nestedScrollViewBody: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) =>
        widgets[index],
        separatorBuilder: (BuildContext context, int index) =>
            Divider(),
        itemCount: widgets.length,
      ),
      safeAreaChildHorizontalPadding: defaultDensePortraitHorizontalPadding,
      appBarActions: subjectCommonActions(context, subject),
    );
  }
}

class _ViewModel {
  final SubjectState subjectState;
  final Function(BuildContext context, int subjectId) getSubject;

  @override
  int get hashCode => subjectState.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _ViewModel && subjectState == other.subjectState;
  }

  factory _ViewModel.fromStore(Store<AppState> store) {
    _getSubject(BuildContext context, int subjectId) {
      if (store.state.subjectState.subjects.containsKey(subjectId)) {
        return null;
      }

      final action = GetSubjectAction(context: context, subjectId: subjectId);
      store.dispatch(action);
    }

    return _ViewModel(
      subjectState: store.state.subjectState,
      getSubject: (BuildContext context, int subjectId) =>
          _getSubject(context, subjectId),
    );
  }

  _ViewModel({@required this.subjectState, @required this.getSubject});
}
