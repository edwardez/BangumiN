import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/discussion/FetchDiscussionRequest.dart';
import 'package:munin/widgets/discussion/rakuen/RakuenHome.dart';

final BuiltList<FetchDiscussionRequest> _allRakuenRequests =
FetchDiscussionRequest.allRakuenRequests();

class DiscussionHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allRakuenRequests.length,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: _allRakuenRequests
                .map(
                  (r) => Tab(text: r.discussionFilter.chineseName),
            )
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              children: _allRakuenRequests
                  .map<Widget>((FetchDiscussionRequest fetchDiscussionRequest) {
                return Container(
                  key: PageStorageKey<FetchDiscussionRequest>(
                      fetchDiscussionRequest),
                  child: RakuenHome(
                    fetchDiscussionRequest: fetchDiscussionRequest,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
