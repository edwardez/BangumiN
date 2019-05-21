import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/widgets/discussion/DiscussionHome.dart';
import 'package:munin/widgets/home/MuninBottomNavigationBar.dart';
import 'package:munin/widgets/progress/Progress.dart';
import 'package:munin/widgets/search/home/SearchHomeDelegate.dart';
import 'package:munin/widgets/timeline/Timeline.dart';
import 'package:munin/widgets/userprofile/UserHome.dart';
import 'package:munin/widgets/userprofile/UserProfileWidget.dart';

class MuninHomePage extends StatefulWidget {
  @override
  _MuninHomePageState createState() => _MuninHomePageState();
}

class _MuninHomePageState extends State<MuninHomePage> {
  MuninTimeline muninTimeline;
  MuninSubjectProgress muninSubjectProgress;
  UserProfileWidget muninUserProfile;
  DiscussionHome discussionHome;
  SearchHomeDelegate searchHomeDelegate;

  final PageController controller = PageController();
  int currentIndex = 0;

  final List<Widget> pages = [
    MuninTimeline(
      key: PageStorageKey('Page1'),
    ),
    MuninSubjectProgress(
      key: PageStorageKey('Page2'),
    ),
    DiscussionHome(
      key: PageStorageKey('Page4'),
    ),
    UserHome(
      key: PageStorageKey('Page3'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onSelectedIndexChanged(int index) {
    if (index == currentIndex) return;

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) {
        return _ViewModel(
          state: store.state,
        );
      },
      builder: (BuildContext builderContext, _ViewModel vm) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: PageStorage(
              child: pages[currentIndex],
              bucket: bucket,
            ),
          ),
          bottomNavigationBar: MuninBottomNavigationBar(
            onSelectedIndexChanged: _onSelectedIndexChanged,
            currentIndex: currentIndex,
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final AppState state;

  const _ViewModel({this.state});

  @override
  int get hashCode => state.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _ViewModel && state == other.state;
  }
}
