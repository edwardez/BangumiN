// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BangumiImage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BangumiImage> _$bangumiImageSerializer =
    new _$BangumiImageSerializer();

class _$BangumiImageSerializer implements StructuredSerializer<BangumiImage> {
  @override
  final Iterable<Type> types = const [BangumiImage, _$BangumiImage];
  @override
  final String wireName = 'BangumiImage';

  @override
  Iterable serialize(Serializers serializers, BangumiImage object,
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
  BangumiImage deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BangumiImageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'large':
          result.large = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'common':
          result.common = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'medium':
          result.medium = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'small':
          result.small = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'grid':
          result.grid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BangumiImage extends BangumiImage {
  @override
  final String large;
  @override
  final String common;
  @override
  final String medium;
  @override
  final String small;
  @override
  final String grid;

  factory _$BangumiImage([void Function(BangumiImageBuilder) updates]) =>
      (new BangumiImageBuilder()..update(updates)).build();

  _$BangumiImage._(
      {this.large, this.common, this.medium, this.small, this.grid})
      : super._() {
    if (large == null) {
      throw new BuiltValueNullFieldError('BangumiImage', 'large');
    }
    if (medium == null) {
      throw new BuiltValueNullFieldError('BangumiImage', 'medium');
    }
    if (small == null) {
      throw new BuiltValueNullFieldError('BangumiImage', 'small');
    }
  }

  @override
  BangumiImage rebuild(void Function(BangumiImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BangumiImageBuilder toBuilder() => new BangumiImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BangumiImage &&
        large == other.large &&
        common == other.common &&
        medium == other.medium &&
        small == other.small &&
        grid == other.grid;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, large.hashCode), common.hashCode), medium.hashCode),
            small.hashCode),
        grid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BangumiImage')
          ..add('large', large)
          ..add('common', common)
          ..add('medium', medium)
          ..add('small', small)
          ..add('grid', grid))
        .toString();
  }
}

class BangumiImageBuilder
    implements Builder<BangumiImage, BangumiImageBuilder> {
  _$BangumiImage _$v;

  String _large;
  String get large => _$this._large;
  set large(String large) => _$this._large = large;

  String _common;
  String get common => _$this._common;
  set common(String common) => _$this._common = common;

  String _medium;
  String get medium => _$this._medium;
  set medium(String medium) => _$this._medium = medium;

  String _small;
  String get small => _$this._small;
  set small(String small) => _$this._small = small;

  String _grid;
  String get grid => _$this._grid;
  set grid(String grid) => _$this._grid = grid;

  BangumiImageBuilder();

  BangumiImageBuilder get _$this {
    if (_$v != null) {
      _large = _$v.large;
      _common = _$v.common;
      _medium = _$v.medium;
      _small = _$v.small;
      _grid = _$v.grid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BangumiImage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BangumiImage;
  }

  @override
  void update(void Function(BangumiImageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BangumiImage build() {
    final _$result = _$v ??
        new _$BangumiImage._(
            large: large,
            common: common,
            medium: medium,
            small: small,
            grid: grid);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
