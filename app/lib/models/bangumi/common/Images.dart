import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'Images.g.dart';

enum ImageSize { Large, Common, Medium, Small, Grid, Unknown }

enum ImageType { UserAvatar, CharacterAvatar, SubjectCover }

abstract class Images implements Built<Images, ImagesBuilder> {
  static const String defaultCoverImage = 'https://bgm.tv/img/no_icon_subject.png';

  @BuiltValueField(wireName: 'large')
  String get large;

  @nullable
  @BuiltValueField(wireName: 'common')
  String get common;

  @BuiltValueField(wireName: 'medium')
  String get medium;

  @BuiltValueField(wireName: 'small')
  String get small;

  @BuiltValueField(wireName: 'grid')
  String get grid;

  Images._();

  factory Images([updates(ImagesBuilder b)]) = _$Images;

  /// initiate [Images] from a Image
  /// this works because bangumi image url follows same pattern
  /// TODO: for some images some image size doesn't exist
  /// i.e. avatar doesn't have a grid version
  /// maybe check image type or let each image type use different image pattern?
  /// if imageType is [ImageSize.Unknown]
  /// constructor will try to guess size type of [imageUrl]
  /// Regarding imageType:
  /// for [ImageType.CharacterAvatar], [ImageSize.Common] is not available
  /// for [ImageType.UserAvatar], [ImageSize.Common] and [ImageSize.Grid] is not available
  /// Image from the larger size tier is used instead
  factory Images.fromImageUrl(
      String imageUrl, ImageSize imageSize, ImageType imageType) {
    if (imageUrl == null) {
      imageUrl = defaultCoverImage;
      return Images.useSameImageUrlForAll(imageUrl);
    }

    String replacePattern;

    if (imageSize != ImageSize.Unknown) {
      switch (imageSize) {
        case ImageSize.Large:
          replacePattern = '/l/';
          break;
        case ImageSize.Common:
          replacePattern = '/c/';
          break;
        case ImageSize.Medium:
          replacePattern = '/m/';
          break;
        case ImageSize.Small:
          replacePattern = '/s/';
          break;
        case ImageSize.Grid:
        default:
          replacePattern = '/g/';
          break;
      }
    } else {
      Match urlMatcher =
          RegExp(r'\/l\/|\/c\/|\/m\/|\/s\/|\/g\/').firstMatch(imageUrl);

      /// `urlMatcher == null` is unexpected, in that case, use original imageUrl for
      /// all sizes
      if (urlMatcher == null) {
        return Images.useSameImageUrlForAll(imageUrl);
      } else {
        replacePattern = urlMatcher.group(0);
      }
    }

    String largeImage = imageUrl.replaceFirst(replacePattern, '/l/');
    String commonImage;
    if (imageType == ImageType.UserAvatar ||
        imageType == ImageType.CharacterAvatar) {
      commonImage = largeImage;
    } else {
      commonImage = imageUrl.replaceFirst(replacePattern, '/c/');
    }

    String mediumImage = imageUrl.replaceFirst(replacePattern, '/m/');
    String smallImage = imageUrl.replaceFirst(replacePattern, '/s/');

    String gridImage;
    if (imageType == ImageType.UserAvatar) {
      gridImage = smallImage;
    } else {
      gridImage = imageUrl.replaceFirst(replacePattern, '/g/');
    }

    return Images((b) => b
      ..large = largeImage
      ..common = commonImage
      ..medium = mediumImage
      ..small = smallImage
      ..grid = gridImage);
  }

  factory Images.useSameImageUrlForAll(String imageUrl) {
    if (imageUrl == null) {
      imageUrl = defaultCoverImage;
    }

    return Images((b) => b
      ..large = imageUrl
      ..common = imageUrl
      ..medium = imageUrl
      ..small = imageUrl
      ..grid = imageUrl);
  }

  String toJson() {
    return json.encode(serializers.serializeWith(Images.serializer, this));
  }

  static Images fromJson(String jsonString) {
    return serializers.deserializeWith(
        Images.serializer, json.decode(jsonString));
  }

  static Serializer<Images> get serializer => _$imagesSerializer;
}
