import 'package:flutter/material.dart';

class HorizontalScrollableWidget extends StatelessWidget {
  final List<Widget> horizontalList;

  final double listHeight;

  final ScrollPhysics physics;

  HorizontalScrollableWidget({
    Key key,
    @required this.horizontalList,
    @required this.listHeight,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: listHeight,
      child: ListView.builder(
        physics: physics,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return horizontalList[index];
        },
        itemCount: horizontalList.length,
      ),
    );
  }
}
