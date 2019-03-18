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
    this.containerPadding = 2,
    this.borderRadius = 8,
    this.borderColor = Colors.black12,
    this.titleMaxLines = 3,
    this.subTitleMaxLines = 2,
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
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),

          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 0.0, vertical: 2.0),
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
