import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/GetDiscussionRequest.dart';
import 'package:munin/widgets/discussion/rakuen/DiscussionBodyWidget.dart';
import 'package:munin/widgets/home/HomePageAppBarTitle.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';

class DiscussionBody {
  final int index;
  final GetDiscussionRequest getDiscussionRequest;
  final DiscussionBodyWidget widget;

  const DiscussionBody({this.index, this.getDiscussionRequest, this.widget});
}

class DiscussionHome extends StatefulWidget {
  final GetDiscussionRequest preferredDiscussionLaunchPage;

  const DiscussionHome({Key key, @required this.preferredDiscussionLaunchPage})
      : super(key: key);

  @override
  _DiscussionHomeState createState() => _DiscussionHomeState();
}

class _DiscussionHomeState extends State<DiscussionHome> {
  final List<DiscussionBody> discussionBodyPages =
      List(GetDiscussionRequest.validGetDiscussionRequests.length);
  final List<DiscussionBodyWidget> pages =
      List(GetDiscussionRequest.validGetDiscussionRequests.length);
  final _oneMuninBarKey = GlobalKey<OneMuninBarState>();

  PageController pageController;

  /// page might be a double, however since munin sets physics to NeverScrollableScrollPhysics
  /// we should be fine
  int get currentIndex {
    return pageController?.page?.round();
  }

  DiscussionBodyWidget _buildDiscussionBodyWidget(
      GetDiscussionRequest request, OneMuninBar oneMuninBar) {
    return DiscussionBodyWidget(
      key: PageStorageKey<GetDiscussionRequest>(request),
      oneMuninBar: oneMuninBar,
      getDiscussionRequest: request,
    );
  }

  void _filterModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<ListTile> options = [];

          for (DiscussionBody page in discussionBodyPages) {
            final request = page.getDiscussionRequest;
            options.add(ListTile(
              title:
              Text(request.discussionFilter.chineseName),
              onTap: () {
                setState(() {
                  if (currentIndex != request.pageIndex) {
                    pageController
                        .jumpToPage(request.pageIndex);
                  }
                  _oneMuninBarKey.currentState.setNewTitle(
                      _buildAppBarTitle(request));
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

    pageController = PageController(
        initialPage: widget.preferredDiscussionLaunchPage.pageIndex);

    final oneMuninBar = OneMuninBar(
      key: _oneMuninBarKey,
      title: _buildAppBarTitle(widget.preferredDiscussionLaunchPage),
    );

    for (GetDiscussionRequest request
        in GetDiscussionRequest.validGetDiscussionRequests) {

      var discussionBody = DiscussionBody(
          widget: _buildDiscussionBodyWidget(request, oneMuninBar),
          getDiscussionRequest: request);

      discussionBodyPages[discussionBody.getDiscussionRequest.pageIndex] =
          discussionBody;
      pages[discussionBody.getDiscussionRequest.pageIndex] =
          discussionBody.widget;
    }
  }

  Widget _buildAppBarTitle(GetDiscussionRequest request) {
    return HomePageAppBarTitle(
      onPressed: _filterModalBottomSheet,
      titleText: request.discussionFilter.chineseName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: pages,
    );
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }
}
