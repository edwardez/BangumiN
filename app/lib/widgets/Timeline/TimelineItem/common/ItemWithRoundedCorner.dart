import 'package:flutter/material.dart';
import 'package:quiver/strings.dart' show isEmpty;

/// a item with name, cover and a rounded corner
/// can be used to display person, subject, character...
class ItemWithRoundedCorner extends StatelessWidget {
  final Color borderColor;
  final double borderRadius;
  final double containerPadding;
  final double paddingBetweenCoverAndTitle;
  final String title;
  final String subtitle;
  final int titleMaxLines;
  final int subTitleMaxLines;
  final Widget leadingWidget;

  const ItemWithRoundedCorner({
    Key key,
    @required this.title,
    this.leadingWidget,
    this.subtitle,
    this.paddingBetweenCoverAndTitle = 10,
    this.containerPadding = 4,
    this.borderRadius = 8,
    this.borderColor = Colors.black12,
    this.titleMaxLines = 1,
    this.subTitleMaxLines = 1,
  }) : super(key: key);

  _buildSubtitle(String subtitle, int subTitleMaxLines) {
    if (isEmpty(subtitle)) {
      return null;
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            subtitle,
            maxLines: subTitleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.all(containerPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: Border.all(color: borderColor)),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: leadingWidget,
            subtitle: _buildSubtitle(subtitle, subTitleMaxLines),
            title: Text(
              title,
              maxLines: titleMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () => null);
  }
}
