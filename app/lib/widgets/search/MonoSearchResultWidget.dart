import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/search/result/MonoSearchResult.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/search/SubjectSearchResultWidget.dart';
import 'package:munin/widgets/shared/images/RoundedElevatedImage.dart';
import 'package:munin/widgets/shared/utils/common.dart';
import 'package:quiver/strings.dart';

/// TODO: we should reuse code in this class and [SubjectSearchResultWidget]
class MonoSearchResultWidget extends StatelessWidget {
  final MonoSearchResult monoSearchResult;
  static const double paddingBetweenSubject = 8.0;
  static const double coverTextPadding = 10.0;
  static const int coverFlex = 2;
  static const int textFlex = 8;

  MonoSearchResultWidget({Key key, @required this.monoSearchResult})
      : super(key: key);

  List<Widget> _buildSubInfoRows(BuildContext context) {
    List<Widget> subInfoRows = [];
    const titleMaxLines = 2;
    const subtitleMaxLines = 1;
    const miscMaxLines = 1;
    TextStyle captionStyle = Theme
        .of(context)
        .textTheme
        .caption;

    subInfoRows.add(Text(
      monoSearchResult.name ?? '',
      maxLines: titleMaxLines,
      overflow: TextOverflow.ellipsis,
    ));
    if (!isEmpty(monoSearchResult.nameCn)) {
      subInfoRows.add(Text(
        monoSearchResult.nameCn,
        style: captionStyle,
        maxLines: subtitleMaxLines,
        overflow: TextOverflow.ellipsis,
      ));
    }

    subInfoRows.add(Text(
      monoSearchResult.miscInfo.join(' / '),
      style: Theme
          .of(context)
          .textTheme
          .caption,
      maxLines: miscMaxLines,
      overflow: TextOverflow.ellipsis,
    ));

    return subInfoRows;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: paddingBetweenSubject),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: RoundedElevatedImage(
                imageUrl: monoSearchResult.images?.grid,
              ),
              flex: coverFlex,
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: textFlex,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: coverTextPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildSubInfoRows(context),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: generateOnTapCallbackForBangumiContent(
          contentType: BangumiContent.Person,
          id: monoSearchResult.id.toString(),
          context: context),
    );
  }
}
