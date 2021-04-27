part of 'BangumiUserAvatar.dart';

Serializer<BangumiUserAvatar> _$customBangumiUserAvatarSerializer =
    new CustomBangumiUserAvatarSerializer();

class CustomBangumiUserAvatarSerializer
    implements StructuredSerializer<BangumiUserAvatar> {
  @override
  final Iterable<Type> types = const [BangumiUserAvatar, _$BangumiUserAvatar];
  @override
  final String wireName = 'BangumiUserAvatar';

  @override
  Iterable<Object> serialize(Serializers serializers, BangumiUserAvatar object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'large',
      serializers.serialize(object.large,
          specifiedType: const FullType(String)),
      'medium',
      serializers.serialize(object.medium,
          specifiedType: const FullType(String)),
      'small',
      serializers.serialize(object.small,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BangumiUserAvatar deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiUserAvatarBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'large':
          result.large = upgradeHttpToHttps(serializers.deserialize(value,
              specifiedType: const FullType(String)) as String);
          break;
        case 'medium':
          result.medium = upgradeHttpToHttps(serializers.deserialize(value,
              specifiedType: const FullType(String)) as String);
          break;
        case 'small':
          result.small = upgradeHttpToHttps(serializers.deserialize(value,
              specifiedType: const FullType(String)) as String);
          break;
      }
    }

    return result.build();
  }
}
