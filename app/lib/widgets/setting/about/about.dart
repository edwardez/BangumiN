import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:munin/widgets/shared/link/LinkTextSpan.dart';

void showMuninAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.body2;
  final TextStyle linkStyle =
      themeData.textTheme.body2.copyWith(color: themeData.accentColor);
  final Widget bangumiNLogo = SvgPicture.asset('assets/logo/bangumin_logo.svg',
      width: 48.0, height: 48.0, semanticsLabel: 'BangumiN Logo');

  showAboutDialog(
    context: context,
    applicationName: 'BangumiN',
    applicationVersion: '0.1.0 / May 2019',
    applicationIcon: bangumiNLogo,
    applicationLegalese: 'The BangumiN Project Authors',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text:
                    'BanguminN（读作Bangu-min或Bangumi-N）是一个基于Flutter开发的Bangumi的第三方app。 ',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '\n\nBanguminN的开发代码开源，发布在',
              ),
              LinkTextSpan(
                style: linkStyle,
                url: 'https://github.com/edwardez/bangumin',
                text: 'Github',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
