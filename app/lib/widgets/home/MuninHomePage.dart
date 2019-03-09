import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/MoreOptions/MoreOptionsHome.dart';
import 'package:munin/widgets/shared/avatar/CachedNetworkImage.dart';

class MuninHomePage extends StatelessWidget {
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
          appBar: AppBar(automaticallyImplyLeading: false, actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: '搜索',
              onPressed: () {},
            ),
            IconButton(
              icon: CachedCircleAvatar(
                  vm.state.currentAuthenticatedUserBasicInfo?.avatar?.medium ??
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
          ]),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Flutter + BangumiN == Munin (a new Bangumi App)'),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('动态')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), title: Text('进度')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('主页')),
            ],
            currentIndex: 0,
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
