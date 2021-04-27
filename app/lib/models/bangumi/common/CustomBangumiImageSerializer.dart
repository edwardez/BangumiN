part of 'BangumiImage.dart';

Serializer<BangumiImage> _$customBangumiImageSerializer =
    new CustomBangumiImageSerializer();

class CustomBangumiImageSerializer
    implements StructuredSerializer<BangumiImage> {
  @override
  final Iterable<Type> types = const [BangumiImage, _$BangumiImage];
  @override
  final String wireName = 'BangumiImage';

  @override
  Iterable<Object> serialize(Serializers serializers, BangumiImage object,
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
    if (object.common != null) {
      result
        ..add('common')
        ..add(serializers.serialize(object.common,
            specifiedType: const FullType(String)));
    }
    if (object.grid != null) {
      result
        ..add('grid')
        ..add(serializers.serialize(object.grid,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BangumiImage deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiImageBuilder();

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
        case 'common':
          result.common = upgradeHttpToHttps(serializers.deserialize(value,
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
        case 'grid':
          result.grid = upgradeHttpToHttps(serializers.deserialize(value,
              specifiedType: const FullType(String)) as String);
          break;
      }
    }

    return result.build();
  }
}
