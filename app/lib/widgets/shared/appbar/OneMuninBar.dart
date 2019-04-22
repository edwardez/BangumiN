import 'package:flutter/material.dart';
import 'package:munin/widgets/MoreOptions/MoreOptionsHome.dart';
import 'package:munin/widgets/search/home/SearchHomeDelegate.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';

/// A unified app bar that's displayed on the top of each munin home page
/// TODO: change avatar to actual user avatar and change fixed constants to
/// variables
/// TODO: figure out whether this appbar can be initialized fewer times
class OneMuninBar extends StatefulWidget {
  /// Right side padding of actions from edge.
  /// A hacky way to pad app bar from right edge
  final double appBarActionRightPadding;

  final Widget title;

  const OneMuninBar({
    Key key,
    this.appBarActionRightPadding = 8.0,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OneMuninBarState();
  }
}

class _OneMuninBarState extends State<OneMuninBar> {
  SearchHomeDelegate searchHomeDelegate;

  @override
  void initState() {
    searchHomeDelegate = SearchHomeDelegate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        centerTitle: true,
        elevation: 0.5,
        title: widget.title,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '搜索',
            onPressed: () {
              showSearch(context: context, delegate: searchHomeDelegate);
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: widget.appBarActionRightPadding),
            child: IconButton(
              icon: CachedCircleAvatar(
                imageUrl: 'https://lain.bgm.tv/pic/user/m/icon.jpg',
                radius: 15.0,

                /// maybe avoid hard coding this value?
              ),
              tooltip: '头像，更多选项',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoreOptionsHomePage()),
                );
              },
            ),
          )
        ]);
  }
}
