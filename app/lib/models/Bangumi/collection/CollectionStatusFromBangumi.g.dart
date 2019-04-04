// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionStatusFromBangumi.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionStatusFromBangumi>
    _$collectionStatusFromBangumiSerializer =
    new _$CollectionStatusFromBangumiSerializer();

class _$CollectionStatusFromBangumiSerializer
    implements StructuredSerializer<CollectionStatusFromBangumi> {
  @override
  final Iterable<Type> types = const [
    CollectionStatusFromBangumi,
    _$CollectionStatusFromBangumi
  ];
  @override
  final String wireName = 'status';

  @override
  Iterable serialize(
      Serializers serializers, CollectionStatusFromBangumi object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(CollectionStatus)),
    ];

    return result;
  }

  @override
  CollectionStatusFromBangumi deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionStatusFromBangumiBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(CollectionStatus))
              as CollectionStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$CollectionStatusFromBangumi extends CollectionStatusFromBangumi {
  @override
  final CollectionStatus type;

  factory _$CollectionStatusFromBangumi(
          [void updates(CollectionStatusFromBangumiBuilder b)]) =>
      (new CollectionStatusFromBangumiBuilder()..update(updates)).build();

  _$CollectionStatusFromBangumi._({this.type}) : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('CollectionStatusFromBangumi', 'type');
    }
  }

  @override
  CollectionStatusFromBangumi rebuild(
          void updates(CollectionStatusFromBangumiBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionStatusFromBangumiBuilder toBuilder() =>
      new CollectionStatusFromBangumiBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionStatusFromBangumi && type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(0, type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionStatusFromBangumi')
          ..add('type', type))
        .toString();
  }
}

class CollectionStatusFromBangumiBuilder
    implements
        Builder<CollectionStatusFromBangumi,
            CollectionStatusFromBangumiBuilder> {
  _$CollectionStatusFromBangumi _$v;

  CollectionStatus _type;
  CollectionStatus get type => _$this._type;
  set type(CollectionStatus type) => _$this._type = type;

  CollectionStatusFromBangumiBuilder();

  CollectionStatusFromBangumiBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionStatusFromBangumi other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionStatusFromBangumi;
  }

  @override
  void update(void updates(CollectionStatusFromBangumiBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionStatusFromBangumi build() {
    final _$result = _$v ?? new _$CollectionStatusFromBangumi._(type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
