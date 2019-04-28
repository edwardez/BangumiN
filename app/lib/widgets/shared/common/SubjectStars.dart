import 'package:flutter/material.dart';
import 'package:munin/styles/theme/common.dart';

/// A read-only subject star widget
/// Currently max stars are 5
class SubjectStars extends StatelessWidget {
  final double subjectScore;
  final double starSize;
  final Color starColor;

  const SubjectStars(
      {Key key,
      @required this.subjectScore,
        this.starSize = 18,
        this.starColor = MuninColor.score})
      : super(key: key);

  /// score: min 0, max 10
  List<Widget> _buildStarIconsWith5StarMax(double score) {
    assert(score <= 10.0 && score >= 0.0);

    const maxStars = 5;
    final int numOfFullStars = score ~/ 2;
    final int numOfHalfStars = score % 2 < 1 ? 0 : 1;
    final int restOfStars = maxStars - numOfFullStars - numOfHalfStars;

    return []
      ..addAll(List.generate(numOfFullStars,
          (index) => Icon(Icons.star, size: starSize, color: starColor)))
      ..addAll(List.generate(numOfHalfStars,
          (index) => Icon(Icons.star_half, size: starSize, color: starColor)))
      ..addAll(List.generate(
          restOfStars,
          (index) =>
              Icon(Icons.star_border, size: starSize, color: starColor)));
  }

  @override
  Widget build(BuildContext context) {
    if (subjectScore == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildStarIconsWith5StarMax(subjectScore),
    );
  }
}
