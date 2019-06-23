import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/social/NetworkServiceTag.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/html/BangumiHtml.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/user/NetworkServiceTagWidget.dart';
import 'package:quiver/strings.dart';

class UserMoreDetails extends StatelessWidget {
  final UserProfile profile;

  const UserMoreDetails({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollViewWithSliverAppBar(
        enableBottomSafeArea: false,
        nestedScrollViewBody: Builder(
          builder: (BuildContext builderContext) {
            return ListView(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              children: <Widget>[
                isEmpty(profile.introductionInPlainText)
                    ? WrappableText(
                        '暂无简介',
                        textStyle: Theme.of(context).textTheme.caption,
                        fit: FlexFit.tight,
                        outerWrapper: OuterWrapper.Row,
                      )
                    : BangumiHtml(
                        html: profile.introductionInHtml,
                        showSpoiler: false,
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
        appBarMainTitle: Text('${profile.basicInfo.nickname}的更多资料'));
  }
}
