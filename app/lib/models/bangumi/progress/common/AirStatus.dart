import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/shared/utils/serializers.dart';

part 'AirStatus.g.dart';

class AirStatus extends EnumClass {
  /// The episode has been aired
  @BuiltValueEnumConst(wireName: 'Air')
  static const AirStatus Aired = _$Aired;

  ///The episode is being aired right now
  @BuiltValueEnumConst(wireName: 'Today')
  static const AirStatus OnAir = _$OnAir;

  /// The episode is not aired yet
  @BuiltValueEnumConst(wireName: 'NA')
  static const AirStatus NotAired = _$NotAired;

  /// The air status is unknown
  /// This value is used during parsing progress html since user episode status
  /// overrides air status on html, bangumi api won't return this value
  /// i.e. user marked an episode as 'watched' regardless the episode is aired or not
  /// and air status will be hidden in this case
  static const AirStatus Unknown = _$Unknown;

  String get chineseName {
    switch (this) {
      case AirStatus.Aired:
        return '已放送';
      case AirStatus.OnAir:
        return '放送中';
      case AirStatus.NotAired:
        return '未放送';
      case AirStatus.Unknown:
      default:
        assert(this == AirStatus.Unknown,
            '$this doesn\'t have a valid chinese name.');
        return '未知';
    }
  }

  const AirStatus._(String name) : super(name);

  static BuiltSet<AirStatus> get values => _$values;

  static AirStatus valueOf(String name) => _$valueOf(name);

  static Serializer<AirStatus> get serializer => _$airStatusSerializer;

  static AirStatus fromWiredName(String wiredName) {
    return serializers.deserializeWith(AirStatus.serializer, wiredName);
  }
}
