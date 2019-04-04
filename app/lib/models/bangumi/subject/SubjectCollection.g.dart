// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectCollection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectCollection> _$subjectCollectionSerializer =
    new _$SubjectCollectionSerializer();

class _$SubjectCollectionSerializer
    implements StructuredSerializer<SubjectCollection> {
  @override
  final Iterable<Type> types = const [SubjectCollection, _$SubjectCollection];
  @override
  final String wireName = 'Collection';

  @override
  Iterable serialize(Serializers serializers, SubjectCollection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'wish',
      serializers.serialize(object.wish, specifiedType: const FullType(int)),
      'collect',
      serializers.serialize(object.collect, specifiedType: const FullType(int)),
      'doing',
      serializers.serialize(object.doing, specifiedType: const FullType(int)),
      'on_hold',
      serializers.serialize(object.onHold, specifiedType: const FullType(int)),
      'dropped',
      serializers.serialize(object.dropped, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  SubjectCollection deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectCollectionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'wish':
          result.wish = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'collect':
          result.collect = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'doing':
          result.doing = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'on_hold':
          result.onHold = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'dropped':
          result.dropped = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectCollection extends SubjectCollection {
  @override
  final int wish;
  @override
  final int collect;
  @override
  final int doing;
  @override
  final int onHold;
  @override
  final int dropped;

  factory _$SubjectCollection([void updates(SubjectCollectionBuilder b)]) =>
      (new SubjectCollectionBuilder()..update(updates)).build();

  _$SubjectCollection._(
      {this.wish, this.collect, this.doing, this.onHold, this.dropped})
      : super._() {
    if (wish == null) {
      throw new BuiltValueNullFieldError('SubjectCollection', 'wish');
    }
    if (collect == null) {
      throw new BuiltValueNullFieldError('SubjectCollection', 'collect');
    }
    if (doing == null) {
      throw new BuiltValueNullFieldError('SubjectCollection', 'doing');
    }
    if (onHold == null) {
      throw new BuiltValueNullFieldError('SubjectCollection', 'onHold');
    }
    if (dropped == null) {
      throw new BuiltValueNullFieldError('SubjectCollection', 'dropped');
    }
  }

  @override
  SubjectCollection rebuild(void updates(SubjectCollectionBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectCollectionBuilder toBuilder() =>
      new SubjectCollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectCollection &&
        wish == other.wish &&
        collect == other.collect &&
        doing == other.doing &&
        onHold == other.onHold &&
        dropped == other.dropped;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, wish.hashCode), collect.hashCode), doing.hashCode),
            onHold.hashCode),
        dropped.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectCollection')
          ..add('wish', wish)
          ..add('collect', collect)
          ..add('doing', doing)
          ..add('onHold', onHold)
          ..add('dropped', dropped))
        .toString();
  }
}

class SubjectCollectionBuilder
    implements Builder<SubjectCollection, SubjectCollectionBuilder> {
  _$SubjectCollection _$v;

  int _wish;
  int get wish => _$this._wish;
  set wish(int wish) => _$this._wish = wish;

  int _collect;
  int get collect => _$this._collect;
  set collect(int collect) => _$this._collect = collect;

  int _doing;
  int get doing => _$this._doing;
  set doing(int doing) => _$this._doing = doing;

  int _onHold;
  int get onHold => _$this._onHold;
  set onHold(int onHold) => _$this._onHold = onHold;

  int _dropped;
  int get dropped => _$this._dropped;
  set dropped(int dropped) => _$this._dropped = dropped;

  SubjectCollectionBuilder();

  SubjectCollectionBuilder get _$this {
    if (_$v != null) {
      _wish = _$v.wish;
      _collect = _$v.collect;
      _doing = _$v.doing;
      _onHold = _$v.onHold;
      _dropped = _$v.dropped;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectCollection other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectCollection;
  }

  @override
  void update(void updates(SubjectCollectionBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectCollection build() {
    final _$result = _$v ??
        new _$SubjectCollection._(
            wish: wish,
            collect: collect,
            doing: doing,
            onHold: onHold,
            dropped: dropped);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
