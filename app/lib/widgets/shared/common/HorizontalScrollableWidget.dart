import 'package:flutter/material.dart';

class HorizontalScrollableWidget extends StatelessWidget {
  final List<Widget> horizontalList;

  final double listHeight;

  HorizontalScrollableWidget({
    Key key,
    @required this.horizontalList,
    @required this.listHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return horizontalList[index];
        },
        itemCount: horizontalList.length,
      ),
    );
  }
}
