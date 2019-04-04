import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:munin/models/Bangumi/mono/Character.dart';
import 'package:munin/models/Bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/widgets/shared/common/HorizontalScrollableWidget.dart';
import 'package:munin/widgets/shared/images/RoundedImageWithVerticalText.dart';

class HorizontalCharacters extends StatelessWidget {
  final BuiltList<Character> characters;
  final double horizontalImagePadding;

  final double imageWidth;
  final double imageHeight;

  /// character has title, subtitle, each counts for 1 factor, we add 1 more for spacing
  final int textFactor = 3;

  HorizontalCharacters(
      {Key key,
      @required this.characters,
      this.horizontalImagePadding = 2.0,
      this.imageHeight = 48.0,
      this.imageWidth = 48.0})
      : super(key: key);

  List<RoundedImageWithVerticalText> _buildCharacterLists(
      BuiltList<Character> characters) {
    List<RoundedImageWithVerticalText> imageWidgets = [];
    for (var character in characters) {
      imageWidgets.add(RoundedImageWithVerticalText(
        contentType: BangumiContent.Character,

        /// TODO: grid/small stores a low-resolution size avatar, medium/large stores a hi-res one
        /// However Bangumi allows user to crop image and produces a corresponding small/grid image
        /// We can let user select using a high-res but incorrectly cropped version
        /// Or a lo-res but correctly cropped version
        imageUrl: character.images.grid,
        id: character.id.toString(),
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        horizontalImagePadding:
            imageWidgets.length == 0 ? 0 : horizontalImagePadding,
        title: character.name,
        subtitle:
            character.actors.length == 0 ? null : character.actors[0].name,
      ));
    }

    return imageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalScrollableWidget(
      horizontalList: _buildCharacterLists(characters),
      listHeight:
          imageHeight + Theme.of(context).textTheme.body1.fontSize * textFactor,
    );
  }
}
