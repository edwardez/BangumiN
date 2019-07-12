import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/BangumiUserAvatar.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:quiver/strings.dart';

part 'BangumiImage.g.dart';

enum ImageSize { Large, Common, Medium, Small, Grid, Unknown }

enum ImageType { UserAvatar, MonoAvatar, SubjectCover, GroupIcon }

abstract class BangumiImage
    implements Built<BangumiImage, BangumiImageBuilder> {
  static const String defaultCoverImage =
      'https://bgm.tv/img/no_icon_subject.png';

  @BuiltValueField(wireName: 'large')
  String get large;

  /// Not available for [ImageType.MonoAvatar] and [ImageType.UserAvatar]
  @nullable
  @BuiltValueField(wireName: 'common')
  String get common;

  @BuiltValueField(wireName: 'medium')
  String get medium;

  @BuiltValueField(wireName: 'small')
  String get small;

  /// Not available for [ImageType.UserAvatar]
  @nullable
  @BuiltValueField(wireName: 'grid')
  String get grid;

  BangumiImage._();

  factory BangumiImage([updates(BangumiImageBuilder b)]) = _$BangumiImage;

  /// initiate [BangumiImage] from a Image
  /// this works because bangumi image url follows same pattern
  /// [imageSize] is the image size of [imageUrl], this constructor will
  /// use these info to guess network addressed of all sizes of this image
  /// TODO: for some images some image size doesn't exist
  /// i.e. avatar doesn't have a grid version
  /// maybe check image type or let each image type use different image pattern?
  /// if ImageSize is [ImageSize.Unknown]
  /// constructor will try to guess size type of [imageUrl]
  /// Regarding imageType:
  /// for [ImageType.MonoAvatar], [ImageSize.Common] is not available
  /// for [ImageType.UserAvatar], [ImageSize.Common] and [ImageSize.Grid] is not available
  /// Image from the larger size tier is used instead
  factory BangumiImage.fromImageUrl(
      String imageUrl, ImageSize imageSize, ImageType imageType) {
    if (isEmpty(imageUrl)) {
      imageUrl = defaultCoverImage;
      return BangumiImage.useSameImageUrlForAll(imageUrl);
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

      /// `urlMatcher == null` means something like a default subject cover image
      /// is used, in that case, use original imageUrl for  all sizes
      if (urlMatcher == null) {
        return BangumiImage.useSameImageUrlForAll(imageUrl);
      } else {
        replacePattern = urlMatcher.group(0);
      }
    }

    String largeImage = imageUrl.replaceFirst(replacePattern, '/l/');

    String commonImage;
    if (imageType == ImageType.UserAvatar ||
        imageType == ImageType.MonoAvatar ||
        imageType == ImageType.GroupIcon) {
      commonImage = largeImage;
    } else {
      commonImage = imageUrl.replaceFirst(replacePattern, '/c/');
    }

    String mediumImage = imageUrl.replaceFirst(replacePattern, '/m/');
    String smallImage = imageUrl.replaceFirst(replacePattern, '/s/');

    String gridImage;
    if (imageType == ImageType.UserAvatar || imageType == ImageType.GroupIcon) {
      gridImage = smallImage;
    } else {
      gridImage = imageUrl.replaceFirst(replacePattern, '/g/');
    }

    return BangumiImage((b) => b
      ..large = largeImage
      ..common = commonImage
      ..medium = mediumImage
      ..small = smallImage
      ..grid = gridImage);
  }

  factory BangumiImage.fromBangumiUserAvatar(BangumiUserAvatar avatar) {
    return BangumiImage((b) => b
      ..large = avatar.large
      ..common = avatar.large
      ..medium = avatar.medium
      ..small = avatar.small
      ..grid = avatar.small);
  }

  factory BangumiImage.useSameImageUrlForAll(String imageUrl) {
    if (imageUrl == null) {
      imageUrl = defaultCoverImage;
    }

    return BangumiImage((b) => b
      ..large = imageUrl
      ..common = imageUrl
      ..medium = imageUrl
      ..small = imageUrl
      ..grid = imageUrl);
  }

  String toJson() {
    return json
        .encode(serializers.serializeWith(BangumiImage.serializer, this));
  }

  static BangumiImage fromJson(String jsonString) {
    return serializers.deserializeWith(
        BangumiImage.serializer, json.decode(jsonString));
  }

  static Serializer<BangumiImage> get serializer => _$bangumiImageSerializer;
}
