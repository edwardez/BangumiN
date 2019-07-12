import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'EpisodeType.g.dart';

class EpisodeType extends EnumClass {
  static const trailerChineseNameSplitter = '/';

  /// A regular episode, it's typically aired on TV or streaming platform.
  /// Only [EpisodeType.Regular] can be affected by [EpisodeUpdateType.CollectUntil]
  @BuiltValueEnumConst(wireName: '0')
  static const EpisodeType Regular = _$Regular;

  /// An episode whose actual type is unknown.
  static const EpisodeType Unknown = _$GeneralNonRegular;

  @BuiltValueEnumConst(wireName: '1')
  static const EpisodeType Special = _$Special;

  @BuiltValueEnumConst(wireName: '2')
  static const EpisodeType Opening = _$Opening;

  @BuiltValueEnumConst(wireName: '3')
  static const EpisodeType Ending = _$Ending;

  @BuiltValueEnumConst(wireName: '4')
  static const EpisodeType Trailer = _$Trailer;

  /// A music anime douga.
  /// See https://en.wikipedia.org/wiki/Anime_music_video
  @BuiltValueEnumConst(wireName: '5')
  static const EpisodeType MAD = _$MAD;

  /// An episode that cannot be categorized, but we know it's something else.
  /// It's different from [EpisodeType.UnknownNonRegular], [EpisodeType.UnknownNonRegular]
  /// is for some non regular episode that cannot cannot be categorized,
  /// and we don't know the actual category.
  @BuiltValueEnumConst(wireName: '6')
  static const EpisodeType OtherNonRegular = _$OtherNonRegular;

  String get chineseName {
    switch (this) {
      case EpisodeType.Regular:
        return '本篇';
      case EpisodeType.Special:
        return '特别篇';
      case EpisodeType.Opening:
        return 'OP';
      case EpisodeType.Ending:
        return 'ED';
      case EpisodeType.Trailer:
        // Note: [ProgressParser.guessEpisodeTypeByChineseName] depends on this
        // name.
        return '预告$trailerChineseNameSplitter宣传$trailerChineseNameSplitter广告';
      case EpisodeType.MAD:
        return 'MAD';
      case EpisodeType.OtherNonRegular:
        return '其他';
      case EpisodeType.Unknown:
      default:
        assert(this == EpisodeType.Unknown,
            '$this dpesn\'t have a valid chinese name.');
        return '未知';
    }
  }

  const EpisodeType._(String name) : super(name);

  static BuiltSet<EpisodeType> get values => _$values;

  static EpisodeType valueOf(String name) => _$valueOf(name);

  static Serializer<EpisodeType> get serializer => _$episodeTypeSerializer;

  static EpisodeType fromWiredName(String wiredName) {
    return serializers.deserializeWith(EpisodeType.serializer, wiredName);
  }
}
