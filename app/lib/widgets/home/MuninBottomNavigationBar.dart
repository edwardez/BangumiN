import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/widgets/shared/utils/Scroll.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/user/notification/NotificationIcon.dart';

class MuninBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MuninBottomNavigationBar({Key key,
    @required this.currentIndex,
    @required this.onSelectedIndexChanged})
      : super(key: key);

  final Function(int tappedIndex) onSelectedIndexChanged;

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(isCupertinoPlatform()
                ? CupertinoIcons.home
                : Icons.home_outlined),
            label: '动态'),
        BottomNavigationBarItem(
            icon: Icon(isCupertinoPlatform()
                ? CupertinoIcons.checkmark_alt
                : Icons.done_rounded),
            label: '进度'),
        BottomNavigationBarItem(
            icon: Icon(isCupertinoPlatform()
                ? CupertinoIcons.person_2
                : Icons.group_outlined),
            label: '讨论'),
        BottomNavigationBarItem(
          icon: NotificationIcon(
            child: Icon(isCupertinoPlatform()
                ? CupertinoIcons.person
                : Icons.person_outline_rounded),
            position: BadgePosition.topRight(top: 0, right: 0),
            padding: EdgeInsets.all(4.0),
          ),
          label: '我的',
        ),
      ],
      onTap: (int tappedIndex) {
        /// If user taps current tab, scroll to the top
        scrollPrimaryScrollControllerToTop(context);
        onSelectedIndexChanged(tappedIndex);
      },
    );

    /// If current theme is dark theme, change `bottomNavigationBar` color
    /// to current primary to distinguish from canvas
    if (isNightTheme(context)) {
      return Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: Theme.of(context).primaryColor),
        child: bottomNavigationBar,
      );
    } else {
      return bottomNavigationBar;
    }
  }
}
