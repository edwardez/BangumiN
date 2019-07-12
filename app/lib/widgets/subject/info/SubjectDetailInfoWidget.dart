import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/info/InfoBoxItem.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/subject/common/SubjectCommonActions.dart';
import 'package:redux/redux.dart';

class SubjectDetailInfoWidget extends StatelessWidget {
  final int subjectId;

  SubjectDetailInfoWidget({
    Key key,
    this.subjectId,
  }) : super(key: key);

  Widget _buildDetailInfoBody(BuildContext context, BangumiSubject subject) {
    List<Widget> wraps = [];

    wraps.add(Text(subject.summary));

    wraps.add(Divider());

    subject.infoBoxRows.forEachKey((a, b) {
      List<Widget> widgets = [];
      widgets.add(Text(
        '$a: ',
        style: captionTextWithBody1Size(context),
      ));
      b.forEach((InfoBoxItem infoBoxItem) {
        if (infoBoxItem.type == BangumiContent.PlainText) {
          widgets.add(Text(infoBoxItem.name));
        } else {
          widgets.add(InkWell(
            child: Text(
              infoBoxItem.name,
              style: body1TextWithLightPrimaryDarkAccentColor(context),
            ),
            onTap: generateOnTapCallbackForBangumiContent(
                contentType: infoBoxItem.type,
                id: infoBoxItem.id.toString(),
                context: context),
          ));
        }
      });
      wraps.add(Wrap(
        children: widgets,
      ));
    });

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return wraps[index];
      },
      itemCount: wraps.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, subjectId),
      distinct: true,
      builder: (BuildContext context, _ViewModel vm) {
        if (subjectId == null || vm.subject == null) {
          return Center(
            child: Text('找不到详细信息'),
          );
        }

        return ScrollViewWithSliverAppBar(
          appBarMainTitle: Text('介绍与制作人员'),
          nestedScrollViewBody: _buildDetailInfoBody(context, vm.subject),
          safeAreaChildPadding: const EdgeInsets.only(
              left: defaultDensePortraitHorizontalOffset,
              right: defaultDensePortraitHorizontalOffset,
              top: largeOffset),
          appBarActions: subjectCommonActions(context, vm.subject),
        );
      },
    );
  }
}

class _ViewModel {
  final BangumiSubject subject;

  @override
  int get hashCode => subject.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _ViewModel && subject == other.subject;
  }

  factory _ViewModel.fromStore(Store<AppState> store, int subjectId) {
    return _ViewModel(
      subject: subjectId == null
          ? null
          : store.state.subjectState.subjects[subjectId],
    );
  }

  _ViewModel({@required this.subject});
}
