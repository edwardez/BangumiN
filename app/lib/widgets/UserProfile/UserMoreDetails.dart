import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/widgets/UserProfile/NetworkServiceTagWidget.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/text/BangumiHtml.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/strings.dart';

class UserMoreDetails extends StatelessWidget {
  final UserProfile profile;

  const UserMoreDetails({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithRegularAppBar(
      safeAreaChild: Builder(
        builder: (BuildContext builderContext) {
          return ListView(
            children: <Widget>[
              isEmpty(profile.introductionInPlainText) ? WrappableText(
                '暂无简介',
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .caption,
                fit: FlexFit.tight,
                outerWrapper: OuterWrapper.Row,
              ) : BangumiHtml(
                html: profile.introductionInHtml,
              ),
              Wrap(
                children: <Widget>[
                  for (NetworkServiceTag tag in profile.networkServiceTags)
                    NetworkServiceTagWidget(tag: tag)
                ],
              )
            ],
          );
        },
      ),
      appBar: AppBar(
        title: Text('${profile.basicInfo.nickname}的更多资料'),
      ),
    );
  }
}
