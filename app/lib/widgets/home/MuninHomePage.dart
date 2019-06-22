import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/general/GeneralSetting.dart';
import 'package:munin/models/bangumi/setting/general/PreferredLaunchNavTab.dart';
import 'package:munin/widgets/discussion/DiscussionHome.dart';
import 'package:munin/widgets/home/MuninBottomNavigationBar.dart';
import 'package:munin/widgets/progress/Progress.dart';
import 'package:munin/widgets/timeline/Timeline.dart';
import 'package:munin/widgets/user/UserHome.dart';

class MuninHomePage extends StatefulWidget {
  final GeneralSetting generalSetting;

  const MuninHomePage({Key key, @required this.generalSetting})
      : super(key: key);

  @override
  _MuninHomePageState createState() => _MuninHomePageState();
}

class _MuninHomePageState extends State<MuninHomePage> {
  static const totalBottomNavNumber = 4;
  final List<Widget> pages = List(totalBottomNavNumber);
  final PageStorageBucket bucket = PageStorageBucket();

  int currentIndex;
  Widget currentPage;

  @override
  void initState() {
    super.initState();

    pages[PreferredLaunchNavTab.Timeline.pageIndex] = MuninTimeline.onHomePage(
      key: PageStorageKey<PreferredLaunchNavTab>(
          PreferredLaunchNavTab.Timeline),
      preferredTimelineLaunchPage: widget.generalSetting
          .preferredTimelineLaunchPage,
    );

    pages[PreferredLaunchNavTab.Progress.pageIndex] = MuninSubjectProgress(
      key: PageStorageKey<PreferredLaunchNavTab>(
          PreferredLaunchNavTab.Progress),
      preferredProgressLaunchPage: widget.generalSetting
          .preferredProgressLaunchPage,
    );

    pages[PreferredLaunchNavTab.Discussion.pageIndex] = DiscussionHome(
      key: PageStorageKey<PreferredLaunchNavTab>(
          PreferredLaunchNavTab.Discussion),
      preferredDiscussionLaunchPage: widget.generalSetting
          .preferredDiscussionLaunchPage,
    );

    pages[PreferredLaunchNavTab.HomePage.pageIndex] = UserHome(
      key: PageStorageKey<PreferredLaunchNavTab>(
          PreferredLaunchNavTab.HomePage),
    );

    currentPage = pages[widget.generalSetting.preferredLaunchNavTab.pageIndex];
    currentIndex = widget.generalSetting.preferredLaunchNavTab.pageIndex;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onSelectedIndexChanged(int index) {
    if (index == currentIndex) return;

    setState(() {
      currentIndex = index;
      currentPage = pages[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: PageStorage(
          child: currentPage,
          bucket: bucket,
        ),
      ),
      bottomNavigationBar: MuninBottomNavigationBar(
        onSelectedIndexChanged: _onSelectedIndexChanged,
        currentIndex: currentIndex,
      ),
    );
  }
}
