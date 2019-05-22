import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/timeline/TimelineBodyWidget.dart';

class TimelineBody {
  final FetchTimelineRequest fetchTimelineRequest;
  final TimelineBodyWidget widget;

  TimelineBody({
    @required this.fetchTimelineRequest,
    @required this.widget,
  });
}

class MuninTimeline extends StatefulWidget {
  final TimelineCategoryFilter preferredTimelineLaunchPage;

  const MuninTimeline({Key key, @required this.preferredTimelineLaunchPage})
      : super(key: key);

  @override
  _MuninTimelineState createState() => _MuninTimelineState();
}

class _MuninTimelineState extends State<MuninTimeline> {
  PageController pageController;


  final List<TimelineBody> timelineBodies = List(
      TimelineCategoryFilter.totalTimelineTypes);
  final List<TimelineBodyWidget> pages = List(
      TimelineCategoryFilter.totalTimelineTypes);

  /// page might be a double, however since munin sets physics to NeverScrollableScrollPhysics
  /// we should be fine
  int get currentIndex {
    assert(pageController.page.toInt() - pageController.page == 0);

    return pageController?.page?.toInt();
  }

  TimelineBodyWidget _buildTimelineBodyWidget(
      FetchTimelineRequest fetchTimelineRequest, OneMuninBar oneMuninBar) {
    return TimelineBodyWidget(
      key: PageStorageKey<FetchTimelineRequest>(
          fetchTimelineRequest),
      oneMuninBar: oneMuninBar,
      fetchTimelineRequest: fetchTimelineRequest,
    );
  }

  void _filterModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<ListTile> options = [];

          for (TimelineBody timelineBody in timelineBodies) {
            options.add(ListTile(
              title: Text(timelineBody.fetchTimelineRequest.chineseName),
              onTap: () {
                setState(() {
                  int pageIndex = timelineBody
                      .fetchTimelineRequest.timelineCategoryFilter.pageIndex;
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

  @override
  void initState() {
    super.initState();

    pageController =
        PageController(
            initialPage: widget.preferredTimelineLaunchPage.pageIndex);

    for (TimelineCategoryFilter filter in TimelineCategoryFilter.values) {
      FetchTimelineRequest request = FetchTimelineRequest((b) =>
      b
        ..timelineSource = TimelineSource.FriendsOnly
        ..timelineCategoryFilter = filter);

      /// Maybe we can initialize only one app bar
      OneMuninBar oneMuninBar = OneMuninBar(
        title: FlatButton(
          onPressed: () {
            _filterModalBottomSheet();
          },
          child: Text(request.chineseName),
        ),
      );

      TimelineBody timelineBody = TimelineBody(
          widget: _buildTimelineBodyWidget(request, oneMuninBar),
          fetchTimelineRequest: request);
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
