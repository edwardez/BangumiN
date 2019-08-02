import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/progress/common/GetProgressRequest.dart';
import 'package:munin/widgets/home/HomePageAppBarTitle.dart';
import 'package:munin/widgets/progress/ProgressBodyWidget.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';

class ProgressBody {
  final GetProgressRequest getProgressRequest;
  final ProgressBodyWidget widget;

  const ProgressBody(
      {@required this.getProgressRequest, @required this.widget});
}

class MuninSubjectProgress extends StatefulWidget {
  final GetProgressRequest preferredProgressLaunchPage;

  const MuninSubjectProgress(
      {Key key, @required this.preferredProgressLaunchPage})
      : super(key: key);

  @override
  _MuninSubjectProgressState createState() => _MuninSubjectProgressState();
}

class _MuninSubjectProgressState extends State<MuninSubjectProgress> {
  final List<ProgressBody> progressBodies =
      List(GetProgressRequest.totalGetProgressRequestTypes);
  final List<Widget> pages =
      List(GetProgressRequest.totalGetProgressRequestTypes);
  final _oneMuninBarKey = GlobalKey<OneMuninBarState>();

  PageController pageController;

  /// page might be a double, however since munin sets physics to NeverScrollableScrollPhysics
  /// we should be fine
  int get currentIndex {
    return pageController?.page?.round();
  }

  ProgressBodyWidget _buildProgressBodyWidget(
      GetProgressRequest getProgressRequest, OneMuninBar oneMuninBar) {
    return ProgressBodyWidget(
      key: PageStorageKey<GetProgressRequest>(getProgressRequest),
      appBar: oneMuninBar,
      subjectTypes: getProgressRequest.requestedSubjectTypes,
    );
  }

  void _filterModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<ListTile> options = [];

          for (ProgressBody progressBody in progressBodies) {
            options.add(ListTile(
              title: Text(progressBody.getProgressRequest.chineseName),
              onTap: () {
                setState(() {
                  if (currentIndex !=
                      progressBody.getProgressRequest.pageIndex) {
                    pageController
                        .jumpToPage(progressBody.getProgressRequest.pageIndex);
                  }
                  _oneMuninBarKey.currentState.setNewTitle(
                      _buildAppBarTitle(progressBody.getProgressRequest));
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
    assert(GetProgressRequest.validGetProgressRequests.length ==
        GetProgressRequest.totalGetProgressRequestTypes);

    pageController = PageController(
        initialPage: widget.preferredProgressLaunchPage.pageIndex);

    final oneMuninBar = OneMuninBar(
      key: _oneMuninBarKey,
      title: _buildAppBarTitle(widget.preferredProgressLaunchPage),
    );

    GetProgressRequest.validGetProgressRequests
        .forEach((GetProgressRequest getProgressRequest) {
      var progressBodyPage = ProgressBody(
        widget: _buildProgressBodyWidget(getProgressRequest, oneMuninBar),
        getProgressRequest: getProgressRequest,
      );
      progressBodies[progressBodyPage.getProgressRequest.pageIndex] =
          progressBodyPage;
      pages[progressBodyPage.getProgressRequest.pageIndex] =
          progressBodyPage.widget;
    });
  }

  Widget _buildAppBarTitle(GetProgressRequest request) {
    return HomePageAppBarTitle(
      onPressed: _filterModalBottomSheet,
      titleText: request.chineseName,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
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
