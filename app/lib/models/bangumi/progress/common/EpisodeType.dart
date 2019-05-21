import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'EpisodeType.g.dart';

class EpisodeType extends EnumClass {
  @BuiltValueEnumConst(wireName: '0')
  static const EpisodeType RegularEpisode = _$MainEpisode;

  /// User cannot perform [EpisodeUpdateType.CollectUntil] a `NonMainEpisode`
  static const EpisodeType NonRegularEpisode = _$NonMainEpisode;

  const EpisodeType._(String name) : super(name);

  static BuiltSet<EpisodeType> get values => _$values;

  static EpisodeType valueOf(String name) => _$valueOf(name);

  static Serializer<EpisodeType> get serializer => _$episodeTypeSerializer;

  static EpisodeType fromWiredName(String wiredName) {
    return serializers.deserializeWith(EpisodeType.serializer, wiredName);
  }
}
