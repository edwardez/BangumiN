import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/Bangumi/subject/InfoBox/InfoBoxItem.dart';
import 'package:munin/models/Bangumi/subject/Subject.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithSliverAppBar.dart';
import 'package:munin/widgets/shared/services/Clipboard.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/subject/common/SubjectCommonActions.dart';
import 'package:redux/redux.dart';

class SubjectDetailInfoWidget extends StatelessWidget {
  final int subjectId;

  SubjectDetailInfoWidget({
    Key key,
    this.subjectId,
  }) : super(key: key);

  Widget _buildDetailInfoBody(BuildContext context, Subject subject) {
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
              style: body1TextWithPrimaryColor(context),
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
      itemBuilder: (BuildContext context, int index) {
        return wraps[index];
      },
      itemCount: wraps.length,
    );
  }

  void _settingModalBottomSheet(BuildContext context, Subject subject) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('复制标题'),
                    onTap: () {
                      ClipboardService.copyAsPlainText(context, subject.name,
                          popContext: true);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('复制简介'),
                    onTap: () {
                      ClipboardService.copyAsPlainText(context, subject.summary,
                          popContext: true);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('复制Staff信息'),
                    onTap: () {
                      ClipboardService.copyAsPlainText(
                          context, subject.infoBoxRowsPlainText,
                          popContext: true);
                    },
                  ),
                ],
              ),
            ),
          );
        });
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

        return ScaffoldWithSliverAppBar(
          appBarMainTitle: '',
          nestedScrollViewBody: _buildDetailInfoBody(context, vm.subject),
          safeAreaChildHorizontalPadding: defaultDensePortraitHorizontalPadding,
          appBarActions: subjectCommonActions(context, vm.subject),
        );
      },
    );
  }
}

class _ViewModel {
  final Subject subject;

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
