import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/widgets/discussion/rakuen/DiscussionBody.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';

final BuiltList<FetchDiscussionRequest> _allRakuenRequests =
FetchDiscussionRequest.allRakuenRequests();

class DiscussionBodyPage {
  final int index;
  final FetchDiscussionRequest fetchDiscussionRequest;
  final DiscussionBody body;

  const DiscussionBodyPage(
      {this.index, this.fetchDiscussionRequest, this.body});
}

class DiscussionHome extends StatefulWidget {
  const DiscussionHome({Key key}) : super(key: key);

  @override
  _DiscussionHomeState createState() => _DiscussionHomeState();
}

class _DiscussionHomeState extends State<DiscussionHome> {
  final PageController pageController = PageController();

  int currentIndex = 0;

  List<DiscussionBodyPage> discussionBodyPages = [];
  List<Widget> pages = [];

  DiscussionBody _buildDiscussionBodyWidget(
      FetchDiscussionRequest fetchDiscussionRequest, OneMuninBar oneMuninBar) {
    return DiscussionBody(
      key: PageStorageKey<FetchDiscussionRequest>(fetchDiscussionRequest),
      oneMuninBar: oneMuninBar,
      fetchDiscussionRequest: fetchDiscussionRequest,
    );
  }

  void _filterModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<ListTile> options = [];

          for (DiscussionBodyPage page in discussionBodyPages) {
            options.add(ListTile(
              title: Text(
                  page.fetchDiscussionRequest.discussionFilter.chineseName),
              onTap: () {
                setState(() {
                  currentIndex = page.index;
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
    for (FetchDiscussionRequest request in _allRakuenRequests) {
      /// Maybe we can initialize only one app bar
      OneMuninBar oneMuninBar = OneMuninBar(
        title: FlatButton(
          onPressed: () {
            _filterModalBottomSheet();
          },
          child: Text(request.discussionFilter.chineseName),
        ),
      );
      discussionBodyPages.add(DiscussionBodyPage(
          index: index,
          body: _buildDiscussionBodyWidget(request, oneMuninBar),
          fetchDiscussionRequest: request));
      index++;
    }

    pages = discussionBodyPages
        .map((DiscussionBodyPage page) => page.body)
        .toList();
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
    pageController.dispose();
    super.dispose();
  }
}
