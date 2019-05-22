import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/progress/common/GetProgressRequest.dart';
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
  final List<Widget> pages = List(
      GetProgressRequest.totalGetProgressRequestTypes);

  PageController pageController;

  /// page might be a double, however since munin sets physics to NeverScrollableScrollPhysics
  /// we should be fine
  int get currentIndex {
    assert(pageController.page.toInt() - pageController.page == 0);

    return pageController?.page?.toInt();
  }


  ProgressBodyWidget _buildProgressBodyWidget(
      GetProgressRequest getProgressRequest, OneMuninBar oneMuninBar) {
    return ProgressBodyWidget(
      key: PageStorageKey<GetProgressRequest>(getProgressRequest),
      oneMuninBar: oneMuninBar,
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
                    pageController.jumpToPage(
                        progressBody.getProgressRequest.pageIndex);
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
    assert(GetProgressRequest.validGetProgressRequests.length ==
        GetProgressRequest.totalGetProgressRequestTypes);

    pageController = PageController(
        initialPage: widget.preferredProgressLaunchPage.pageIndex);

    GetProgressRequest.validGetProgressRequests
        .forEach((GetProgressRequest getProgressRequest) {
      OneMuninBar oneMuninBar = OneMuninBar(
        title: FlatButton(
          onPressed: () {
            _filterModalBottomSheet();
          },
          child: Text(getProgressRequest.chineseName),
        ),
      );

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
