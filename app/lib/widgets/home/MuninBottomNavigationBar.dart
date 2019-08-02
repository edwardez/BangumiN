import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/utils/Scroll.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:munin/widgets/user/notification/NotificationIcon.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(OMIcons.home), title: Text('动态')),
        BottomNavigationBarItem(icon: Icon(OMIcons.done), title: Text('进度')),
        BottomNavigationBarItem(icon: Icon(OMIcons.group), title: Text('讨论')),
        BottomNavigationBarItem(
          icon: NotificationIcon(
            child: Icon(OMIcons.person),
            position: BadgePosition.topRight(top: 0, right: 0),
            padding: EdgeInsets.all(4.0),
          ),
          title: Text('主页'),
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
