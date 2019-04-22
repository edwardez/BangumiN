import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/timeline/common/FetchTimelineRequest.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineCategoryFilter.dart';
import 'package:munin/models/bangumi/timeline/common/TimelineSource.dart';
import 'package:munin/widgets/Timeline/TimelineBody.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';

class TimelineBodyPage {
  final int index;
  final FetchTimelineRequest fetchTimelineRequest;
  final TimelineBody body;

  TimelineBodyPage({@required this.index,
    @required this.fetchTimelineRequest,
    @required this.body});
}

class MuninTimeline extends StatefulWidget {
  const MuninTimeline({Key key}) : super(key: key);

  @override
  _MuninTimelineState createState() => _MuninTimelineState();
}

class _MuninTimelineState extends State<MuninTimeline> {
  final PageController pageController = PageController();

  int currentIndex = 0;

  List<TimelineBodyPage> timelineBodyViews = [];
  List<Widget> pages = [];

  TimelineBody _buildTimelineBodyWidget(
      FetchTimelineRequest fetchTimelineRequest, OneMuninBar oneMuninBar) {
    return TimelineBody(
      key: PageStorageKey<FetchTimelineRequest>(fetchTimelineRequest),
      oneMuninBar: oneMuninBar,
      fetchTimelineRequest: fetchTimelineRequest,
    );
  }

  void _filterModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<ListTile> options = [];

          for (TimelineBodyPage timelineBodyView in timelineBodyViews) {
            options.add(ListTile(
              title: Text(timelineBodyView.fetchTimelineRequest.chineseName),
              onTap: () {
                setState(() {
                  currentIndex = timelineBodyView.index;
                  pageController.jumpToPage(currentIndex);
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

    int index = 0;
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
      timelineBodyViews.add(TimelineBodyPage(
          index: index,
          body: _buildTimelineBodyWidget(request, oneMuninBar),
          fetchTimelineRequest: request));
      index++;
    }

    pages =
        timelineBodyViews.map((TimelineBodyPage view) => view.body).toList();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: pages,
    );
  }
}
