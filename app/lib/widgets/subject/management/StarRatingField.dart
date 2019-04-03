import 'package:flutter/material.dart';
import 'package:munin/styles/theme/common.dart';

typedef void RatingChangeCallback(double rating);

/// adapted from https://github.com/goops17/flutter_rating/blob/master/lib/flutter_rating.dart
class StarRatingField extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;
  final Color borderColor;
  final double size;
  final MainAxisAlignment mainAxisAlignment;
  final RatingChangeCallback onRatingChanged;

  StarRatingField({
    this.starCount = 10,
    this.rating = .0,
    this.onRatingChanged,
    this.color = MuninColor.score,
    this.borderColor,
    this.size,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  State<StatefulWidget> createState() {
    return _StarRatingFieldState();
  }
}

class _StarRatingFieldState extends State<StarRatingField> {
  Widget buildStar(BuildContext context, int index) {
    IconData iconData;
    Color iconColor;
    double iconSize = widget.size;

    if (index >= widget.rating) {
      iconData = Icons.star_border;
      iconColor = widget.color ?? Theme.of(context).primaryColor;
    } else if (index > widget.rating - 1 && index < widget.rating) {
      iconData = Icons.star_half;
      iconColor = widget.borderColor ?? Theme.of(context).buttonColor;
    } else {
      iconData = Icons.star;
      iconColor = widget.color ?? Theme.of(context).primaryColor;
    }
    return InkResponse(
      child: Icon(
        iconData,
        color: iconColor,
        size: iconSize,
      ),
      onTap: widget.onRatingChanged == null
          ? null
          : () => widget.onRatingChanged(index + 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: List.generate(
        widget.starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
