import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/progress/common/GetProgressRequest.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/widgets/progress/ProgressBody.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';


final List<GetProgressRequest> validGetProgressRequests = [
  GetProgressRequest((b) =>
  b
    ..requestedSubjectTypes.addAll(
        [SubjectType.Anime, SubjectType.Real, SubjectType.Book])),
  GetProgressRequest((b) =>
  b
    ..requestedSubjectTypes.addAll([SubjectType.Anime])),
  GetProgressRequest((b) =>
  b
    ..requestedSubjectTypes.addAll([SubjectType.Real])),
  GetProgressRequest((b) =>
  b
    ..requestedSubjectTypes.addAll([SubjectType.Book])),
];

class ProgressBodyPage {
  final int index;
  final GetProgressRequest getProgressRequest;
  final ProgressBody body;

  ProgressBodyPage({@required this.index,
    @required this.getProgressRequest,
    @required this.body});
}

class MuninSubjectProgress extends StatefulWidget {
  MuninSubjectProgress({Key key}) : super(key: key);

  @override
  _MuninSubjectProgressState createState() => _MuninSubjectProgressState();
}

class _MuninSubjectProgressState extends State<MuninSubjectProgress> {
  final PageController pageController = PageController();

  int currentIndex = 0;

  List<ProgressBodyPage> progressBodyViews = [];
  List<Widget> pages = [];

  ProgressBody _buildProgressBodyWidget(GetProgressRequest getProgressRequest,
      OneMuninBar oneMuninBar) {
    return ProgressBody(
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

          for (ProgressBodyPage progressBodyView in progressBodyViews) {
            options.add(ListTile(
              title: Text(progressBodyView.getProgressRequest.chineseName),
              onTap: () {
                setState(() {
                  currentIndex = progressBodyView.index;
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

    validGetProgressRequests.forEach((GetProgressRequest getProgressRequest) {
      OneMuninBar oneMuninBar = OneMuninBar(
        title: FlatButton(
          onPressed: () {
            _filterModalBottomSheet();
          },
          child: Text(getProgressRequest.chineseName),
        ),
      );
      progressBodyViews.add(ProgressBodyPage(
        index: index,
        body: _buildProgressBodyWidget(getProgressRequest, oneMuninBar),
        getProgressRequest: getProgressRequest,
      ));
      index++;
    });


    pages =
        progressBodyViews.map((ProgressBodyPage view) => view.body).toList();
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
