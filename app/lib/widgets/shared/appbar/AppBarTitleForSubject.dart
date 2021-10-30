import 'package:flutter/material.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/cover/CachedRoundedCover.dart';

class AppBarTitleForSubject extends StatelessWidget {
  static const appBarCoverSize = 30.0;

  static final fallbackSubjectCover = bangumiTextOnlySubjectCover;

  final String coverUrl;

  final String title;

  const AppBarTitleForSubject({
    Key key,
    @required this.coverUrl,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    ThemeData(
      appBarTheme: AppBarTheme(
          textTheme: TextTheme(
              headline6: ThemeData()
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white))),
    );
    Scaffold(
      appBar: AppBar(
        title: Text('s'),
      ),
    );
    AppBar();
    return Row(
      children: <Widget>[
        CachedRoundedCover(
          height: appBarCoverSize,
          width: appBarCoverSize,
          imageUrl: coverUrl ?? fallbackSubjectCover,
        ),
        Padding(
          padding: EdgeInsets.only(left: mediumOffset),
        ),
        if (title != null)
          Flexible(
              child: Text(
                title,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.bodyText2,
          )),
      ],
    );
  }
}
