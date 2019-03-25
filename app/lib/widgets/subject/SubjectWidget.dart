import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/redux/subject/SubjectState.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithAppBar.dart';
import 'package:munin/widgets/subject/MainPage/CharactersPreview.dart';
import 'package:munin/widgets/subject/MainPage/CommentsPreview.dart';
import 'package:munin/widgets/subject/MainPage/RelatedSubjectsPreview.dart';
import 'package:munin/widgets/subject/MainPage/SubjectCoverAndBasicInfo.dart';
import 'package:munin/widgets/subject/MainPage/SubjectSummary.dart';
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
        final action = GetSubjectAction(context: context, subjectId: subjectId);
        store.dispatch(action);
      },
      builder: (BuildContext context, _ViewModel vm) {
        /// TODO: write a generic widget to handle malformed parameter case like subjectId == null
        if (vm.subjectState.subjects[subjectId] == null) {
          return ScaffoldWithAppBar(
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

    widgets.add(Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: OutlineButton(
                  child: Text('观看进度管理'),
                  textColor: Theme.of(context).primaryColor,
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                  onPressed: () {},
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
                child: OutlineButton(
                  child: Text('编辑收藏'),
                  textColor: Theme.of(context).primaryColor,
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    ));

    widgets.add(SubjectSummary(subject: subject));

    if (!isIterableNullOrEmpty(subject.characters)) {
      widgets.add(CharactersPreview(subject: subject));
    }

    if (!isBuiltListMultimapNullOrEmpty(subject.relatedSubjects)) {
      widgets.add(RelatedSubjectsPreview(subject: subject));
    }

    if (!isIterableNullOrEmpty(subject.commentsPreview)) {
      widgets.add(CommentsPreview(subject: subject));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: portraitDefaultHorizontalPadding),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) =>
                    widgets[index],
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: widgets.length,
              ))),
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
