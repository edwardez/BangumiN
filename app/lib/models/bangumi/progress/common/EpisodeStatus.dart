import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:munin/shared/utils/serializers.dart';
import 'package:munin/styles/theme/Colors.dart';
import 'package:munin/styles/theme/Common.dart';

part 'EpisodeStatus.g.dart';

class EpisodeStatus extends EnumClass {
  /// User listed this episode on their wish list
  @BuiltValueEnumConst(wireName: '1')
  static const EpisodeStatus Wish = _$Wish;

  /// User has watched this episode
  @BuiltValueEnumConst(wireName: '2')
  static const EpisodeStatus Completed = _$Completed;

  /// User decides to drop this episode
  @BuiltValueEnumConst(wireName: '3')
  static const EpisodeStatus Dropped = _$Dropped;

  /// HACKHACK: '9999' doesn't exist in bangumi api, it's used as a magic munin
  /// internal value for convenience
  @BuiltValueEnumConst(wireName: '9999')
  static const EpisodeStatus Pristine = _$Pristine;

  /// Api won't return this value
  /// Status for this episode is unknown
  static const EpisodeStatus Unknown = _$Unknown;

  @memoized
  String get wiredName {
    switch (this) {
      case EpisodeStatus.Pristine:
        return '9999';
      case EpisodeStatus.Wish:
        return '1';
      case EpisodeStatus.Completed:
        return '2';
      case EpisodeStatus.Dropped:
        return '3';
      default:
        assert(false, '$this doesn\'t have a valid wired name');
        return '2';
    }
  }

  @memoized
  String get chineseName {
    switch (this) {
      case EpisodeStatus.Pristine:
        return '未看';
      case EpisodeStatus.Wish:
        return '想看';
      case EpisodeStatus.Completed:
        return '看过';
      case EpisodeStatus.Dropped:
        return '抛弃';
      default:
        assert(this == EpisodeStatus.Unknown,
        '$this doesn\'t have a valid wired name');
        return '-';
    }
  }

  static Color getColor(BuildContext context, EpisodeStatus status) {
    switch (status) {
      case EpisodeStatus.Wish:
        return Theme
            .of(context)
            .brightness == Brightness.dark
            ? bangumiPink.shade200
            : Theme
            .of(context)
            .accentColor;
      case EpisodeStatus.Dropped:
        return Theme
            .of(context)
            .unselectedWidgetColor;
      case EpisodeStatus.Completed:
        return lightPrimaryDarkAccentColor(context);
      default:
        return Theme
            .of(context)
            .unselectedWidgetColor;
    }
  }

  const EpisodeStatus._(String name) : super(name);

  static BuiltSet<EpisodeStatus> get values => _$values;

  static EpisodeStatus valueOf(String name) => _$valueOf(name);

  static Serializer<EpisodeStatus> get serializer => _$episodeStatusSerializer;

  static EpisodeStatus fromWiredName(String wiredName) {
    return serializers.deserializeWith(EpisodeStatus.serializer, wiredName);
  }
}
