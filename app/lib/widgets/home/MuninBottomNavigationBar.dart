import 'package:flutter/material.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MuninBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const MuninBottomNavigationBar(
      {Key key,
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
        BottomNavigationBarItem(icon: Icon(OMIcons.person), title: Text('主页')),
      ],
      onTap: (int tappedIndex) {
        /// If user taps current tab, scroll to the top
        if (PrimaryScrollController.of(context) != null &&
            PrimaryScrollController.of(context).hasClients) {
          /// eyeballed values from `_handleStatusBarTap` in `scaffold.dart`
          PrimaryScrollController.of(context).animateTo(0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linearToEaseOut);
        }
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
