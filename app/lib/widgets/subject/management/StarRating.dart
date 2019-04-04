import 'package:flutter/material.dart';
import 'package:munin/styles/theme/common.dart';

typedef void RatingChangeCallback(double rating);

/// adapted from https://github.com/goops17/flutter_rating/blob/master/lib/flutter_rating.dart
class StarRating extends StatelessWidget {
  /// default to true, add a clear icon on the left to allow user clear rating
  final bool allowClearRating;
  final int starCount;
  final double rating;
  final Color color;
  final Color borderColor;
  final double size;
  final MainAxisAlignment mainAxisAlignment;
  final RatingChangeCallback onRatingChanged;

  /// for some reason MediaQuery.of(context).size.width won't correctly returns
  /// padding, thus we have a hack here to get a pass-in padding
  final double horizontalPadding;

  StarRating({
    this.starCount = 10,
    this.rating = .0,
    this.allowClearRating = true,
    this.onRatingChanged,
    this.color = MuninColor.score,
    this.horizontalPadding = defaultPortraitHorizontalPadding,
    this.borderColor,
    this.size,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  Widget _buildStarIcon(BuildContext context, int index) {
    IconData iconData;
    Color iconColor;
    int totalIcons = starCount + (allowClearRating ? 1 : 0);
    double totalWidth =
        MediaQuery.of(context).size.width - horizontalPadding * 2;
    double ratingStarSizeRelativeToScreen = totalWidth / totalIcons;

    if (index >= rating) {
      iconData = Icons.star_border;
      iconColor = color ?? Theme.of(context).primaryColor;
    } else if (index > rating - 1 && index < rating) {
      iconData = Icons.star_half;
      iconColor = borderColor ?? Theme.of(context).buttonColor;
    } else {
      iconData = Icons.star;
      iconColor = color ?? Theme.of(context).primaryColor;
    }
    return InkWell(
      child: Icon(
        iconData,
        color: iconColor,
        size: size ?? ratingStarSizeRelativeToScreen,
      ),
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
    );
  }

  Widget _buildClearStarIcon(BuildContext context) {
    return InkResponse(
      child: Icon(
        Icons.remove_circle_outline,
        color: Theme.of(context).colorScheme.secondary,
        size: size,
      ),
      onTap: onRatingChanged == null ? null : () => onRatingChanged(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (allowClearRating) {
      children.add(_buildClearStarIcon(context));
    }

    children.addAll(List.generate(
      starCount,
      (index) => _buildStarIcon(context, index),
    ));

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}
