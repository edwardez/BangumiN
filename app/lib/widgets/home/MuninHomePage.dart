import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/MoreOptions/MoreOptionsHome.dart';
import 'package:munin/widgets/Progress/Progress.dart';
import 'package:munin/widgets/TimeLine/Timeline.dart';
import 'package:munin/widgets/UserProfile/UserHome.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MuninHomePage extends StatefulWidget {
  @override
  _MuninHomePageState createState() => _MuninHomePageState();
}

class _MuninHomePageState extends State<MuninHomePage> {
  MuninTimeline muninTimeline;
  MuninSubjectProgress muninSubjectProgress;
  MuninUserProfile muninUserProfile;

  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    muninTimeline = MuninTimeline();
    muninSubjectProgress = MuninSubjectProgress();
    muninUserProfile = MuninUserProfile();
    super.initState();
  }

  _onSelectedIndexChanged(int index) {
    if (index == currentIndex) return;

    setState(() {
      currentIndex = index;
      controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel(
          state: store.state,
        );
      },
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: false,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          tooltip: '搜索',
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: CachedCircleAvatar(
                              imageUrl: vm
                                  .state
                                  .currentAuthenticatedUserBasicInfo
                                  ?.avatar
                                  ?.medium ??
                                  'https://lain.bgm.tv/pic/user/m/icon.jpg'),
                          tooltip: '头像，更多选项',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoreOptionsHomePage()),
                            );
                          },
                        )
                      ])
                ];
              },
              body: PageView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  muninTimeline,
                  muninSubjectProgress,
                  muninUserProfile
                ],
                onPageChanged: (index) => setState(() => currentIndex = index),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(OMIcons.home), title: Text('动态')),
              BottomNavigationBarItem(
                  icon: Icon(OMIcons.done), title: Text('进度')),
              BottomNavigationBarItem(
                  icon: Icon(OMIcons.person), title: Text('主页')),
            ],
            onTap: _onSelectedIndexChanged,
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final AppState state;

  _ViewModel({this.state});
}
