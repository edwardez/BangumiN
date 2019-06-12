// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectionStatusDistribution.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionStatusDistribution>
    _$collectionStatusDistributionSerializer =
    new _$CollectionStatusDistributionSerializer();

class _$CollectionStatusDistributionSerializer
    implements StructuredSerializer<CollectionStatusDistribution> {
  @override
  final Iterable<Type> types = const [
    CollectionStatusDistribution,
    _$CollectionStatusDistribution
  ];
  @override
  final String wireName = 'Collection';

  @override
  Iterable serialize(
      Serializers serializers, CollectionStatusDistribution object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'wish',
      serializers.serialize(object.wish, specifiedType: const FullType(int)),
      'collect',
      serializers.serialize(object.completed,
          specifiedType: const FullType(int)),
      'doing',
      serializers.serialize(object.inProgress,
          specifiedType: const FullType(int)),
      'on_hold',
      serializers.serialize(object.onHold, specifiedType: const FullType(int)),
      'dropped',
      serializers.serialize(object.dropped, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  CollectionStatusDistribution deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionStatusDistributionBuilder();

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
          result.completed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'doing':
          result.inProgress = serializers.deserialize(value,
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

class _$CollectionStatusDistribution extends CollectionStatusDistribution {
  @override
  final int wish;
  @override
  final int completed;
  @override
  final int inProgress;
  @override
  final int onHold;
  @override
  final int dropped;

  factory _$CollectionStatusDistribution(
          [void Function(CollectionStatusDistributionBuilder) updates]) =>
      (new CollectionStatusDistributionBuilder()..update(updates)).build();

  _$CollectionStatusDistribution._(
      {this.wish, this.completed, this.inProgress, this.onHold, this.dropped})
      : super._() {
    if (wish == null) {
      throw new BuiltValueNullFieldError(
          'CollectionStatusDistribution', 'wish');
    }
    if (completed == null) {
      throw new BuiltValueNullFieldError(
          'CollectionStatusDistribution', 'completed');
    }
    if (inProgress == null) {
      throw new BuiltValueNullFieldError(
          'CollectionStatusDistribution', 'inProgress');
    }
    if (onHold == null) {
      throw new BuiltValueNullFieldError(
          'CollectionStatusDistribution', 'onHold');
    }
    if (dropped == null) {
      throw new BuiltValueNullFieldError(
          'CollectionStatusDistribution', 'dropped');
    }
  }

  @override
  CollectionStatusDistribution rebuild(
          void Function(CollectionStatusDistributionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionStatusDistributionBuilder toBuilder() =>
      new CollectionStatusDistributionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionStatusDistribution &&
        wish == other.wish &&
        completed == other.completed &&
        inProgress == other.inProgress &&
        onHold == other.onHold &&
        dropped == other.dropped;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, wish.hashCode), completed.hashCode),
                inProgress.hashCode),
            onHold.hashCode),
        dropped.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionStatusDistribution')
          ..add('wish', wish)
          ..add('completed', completed)
          ..add('inProgress', inProgress)
          ..add('onHold', onHold)
          ..add('dropped', dropped))
        .toString();
  }
}

class CollectionStatusDistributionBuilder
    implements
        Builder<CollectionStatusDistribution,
            CollectionStatusDistributionBuilder> {
  _$CollectionStatusDistribution _$v;

  int _wish;
  int get wish => _$this._wish;
  set wish(int wish) => _$this._wish = wish;

  int _completed;
  int get completed => _$this._completed;
  set completed(int completed) => _$this._completed = completed;

  int _inProgress;
  int get inProgress => _$this._inProgress;
  set inProgress(int inProgress) => _$this._inProgress = inProgress;

  int _onHold;
  int get onHold => _$this._onHold;
  set onHold(int onHold) => _$this._onHold = onHold;

  int _dropped;
  int get dropped => _$this._dropped;
  set dropped(int dropped) => _$this._dropped = dropped;

  CollectionStatusDistributionBuilder();

  CollectionStatusDistributionBuilder get _$this {
    if (_$v != null) {
      _wish = _$v.wish;
      _completed = _$v.completed;
      _inProgress = _$v.inProgress;
      _onHold = _$v.onHold;
      _dropped = _$v.dropped;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionStatusDistribution other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionStatusDistribution;
  }

  @override
  void update(void Function(CollectionStatusDistributionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionStatusDistribution build() {
    final _$result = _$v ??
        new _$CollectionStatusDistribution._(
            wish: wish,
            completed: completed,
            inProgress: inProgress,
            onHold: onHold,
            dropped: dropped);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
