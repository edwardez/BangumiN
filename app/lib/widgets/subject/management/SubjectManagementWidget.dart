import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/router/routes.dart';

class SubjectManagementWidget extends StatelessWidget {
  final BangumiSubject subject;

  const SubjectManagementWidget({Key key, @required this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  onPressed: () {
                    Application.router.navigateTo(
                        context,
                        Routes.subjectCollectionManagementRoute
                            .replaceFirst(':subjectId', subject.id?.toString()),
                        transition: TransitionType.nativeModal);
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
