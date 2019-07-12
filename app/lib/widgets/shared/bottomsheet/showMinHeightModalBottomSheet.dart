import 'package:flutter/material.dart';

showMinHeightModalBottomSheet(BuildContext context, List<Widget> children) {
  return showModalBottomSheet(
      context: context,
      builder: (innerContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );
      });
}
