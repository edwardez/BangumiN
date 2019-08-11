import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/GetTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/widgets/home/HomePageAppBarTitle.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/button/FlatButtonWithTrailingIcon.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TimelineBody {
  final GetTimelineRequest getTimelineRequest;
  final TimelineBodyWidget widget;

  TimelineBody({
    @required this.getTimelineRequest,
    @required this.widget,
  });
}

class MuninTimeline extends StatefulWidget {
  final TimelineCategoryFilter preferredTimelineLaunchPage;

  final TimelineSource timelineSource;

  /// If [timelineSource] is [TimelineSource.UserProfile]
  /// [username] must not be null
  final String username;

  const MuninTimeline.onHomePage({
    Key key,
    @required this.preferredTimelineLaunchPage,
    this.timelineSource = TimelineSource.OnlyFriends,
  })  : this.username = null,
        super(key: key);

  const MuninTimeline.onUserProfile({
    Key key,
    @required this.username,
    this.preferredTimelineLaunchPage = TimelineCategoryFilter.AllFeeds,
  })  : this.timelineSource = TimelineSource.UserProfile,
        super(key: key);

  @override
  _MuninTimelineState createState() => _MuninTimelineState();
}

class _MuninTimelineState extends State<MuninTimeline> {
  PageController pageController;
  final _oneMuninBarKey = GlobalKey<OneMuninBarState>();

  final List<TimelineBody> timelineBodies =
      List(TimelineCategoryFilter.totalTimelineTypes);
  final List<TimelineBodyWidget> pages =
      List(TimelineCategoryFilter.totalTimelineTypes);

  /// page might be a double, however since munin sets physics to NeverScrollableScrollPhysics
  /// we should be fine
  int get currentIndex {
    return pageController?.page?.round();
  }

  TimelineBodyWidget _buildTimelineBodyWidget(
      GetTimelineRequest request, Widget appBar) {
    return TimelineBodyWidget(
      key: PageStorageKey<GetTimelineRequest>(request),
      appBar: appBar,
      getTimelineRequest: request,
    );
  }

  void _filterModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<ListTile> options = [];

          for (TimelineBody timelineBody in timelineBodies) {
            options.add(ListTile(
              title: Text(timelineBody.getTimelineRequest.chineseName),
              onTap: () {
                setState(() {
                  int pageIndex = timelineBody
                      .getTimelineRequest.timelineCategoryFilter.pageIndex;
                  if (currentIndex != pageIndex) {
                    pageController.jumpToPage(pageIndex);
                  }
                });
                Navigator.pop(context);
              },
            ));
          }

          return SafeArea(
            bottom: false,
            child: ListView(
              children: options,
            ),
          );
        });
  }

  Widget _buildAppBarTitle(GetTimelineRequest request) {
    return HomePageAppBarTitle(
      onPressed: _filterModalBottomSheet,
      titleText: request.chineseName,
    );
  }

  @override
  void initState() {
    super.initState();

    pageController = PageController(
        initialPage: widget.preferredTimelineLaunchPage.pageIndex);

    final preferredPageRequest = GetTimelineRequest((b) =>
    b
      ..timelineSource = widget.timelineSource
      ..username = widget.username
      ..timelineCategoryFilter = widget.preferredTimelineLaunchPage);
    Widget appBar = OneMuninBar(
      key: _oneMuninBarKey,
      title: _buildAppBarTitle(preferredPageRequest),
    );

    for (TimelineCategoryFilter filter in TimelineCategoryFilter.values) {
      GetTimelineRequest request = GetTimelineRequest((b) => b
        ..timelineSource = widget.timelineSource
        ..username = widget.username
        ..timelineCategoryFilter = filter);

      if (request.timelineSource == TimelineSource.UserProfile) {
        appBar = SliverAppBar(
          pinned: true,
          title: FlatButtonWithTrailingIcon(
            onPressed: () {
              _filterModalBottomSheet();
            },
            label: Text(request.chineseName),
            icon: Icon(OMIcons.expandMore),
          ),
        );
      } else {
        appBar = OneMuninBar(
          title: _buildAppBarTitle(request),
        );
      }

      TimelineBody timelineBody = TimelineBody(
          widget: _buildTimelineBodyWidget(request, appBar),
          getTimelineRequest: request);
      timelineBodies[filter.pageIndex] = timelineBody;
      pages[filter.pageIndex] = timelineBody.widget;
    }
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: pages,
    );
  }
}
