// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgressState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProgressState> _$progressStateSerializer =
    new _$ProgressStateSerializer();

class _$ProgressStateSerializer implements StructuredSerializer<ProgressState> {
  @override
  final Iterable<Type> types = const [ProgressState, _$ProgressState];
  @override
  final String wireName = 'ProgressState';

  @override
  Iterable serialize(Serializers serializers, ProgressState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'progresses',
      serializers.serialize(object.progresses,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(SubjectType),
            const FullType(
                BuiltList, const [const FullType(InProgressCollection)])
          ])),
    ];

    return result;
  }

  @override
  ProgressState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProgressStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'progresses':
          result.progresses.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(SubjectType),
                const FullType(
                    BuiltList, const [const FullType(InProgressCollection)])
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$ProgressState extends ProgressState {
  @override
  final BuiltMap<SubjectType, BuiltList<InProgressCollection>> progresses;

  factory _$ProgressState([void Function(ProgressStateBuilder) updates]) =>
      (new ProgressStateBuilder()..update(updates)).build();

  _$ProgressState._({this.progresses}) : super._() {
    if (progresses == null) {
      throw new BuiltValueNullFieldError('ProgressState', 'progresses');
    }
  }

  @override
  ProgressState rebuild(void Function(ProgressStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProgressStateBuilder toBuilder() => new ProgressStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProgressState && progresses == other.progresses;
  }

  @override
  int get hashCode {
    return $jf($jc(0, progresses.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProgressState')
          ..add('progresses', progresses))
        .toString();
  }
}

class ProgressStateBuilder
    implements Builder<ProgressState, ProgressStateBuilder> {
  _$ProgressState _$v;

  MapBuilder<SubjectType, BuiltList<InProgressCollection>> _progresses;
  MapBuilder<SubjectType, BuiltList<InProgressCollection>> get progresses =>
      _$this._progresses ??=
          new MapBuilder<SubjectType, BuiltList<InProgressCollection>>();
  set progresses(
          MapBuilder<SubjectType, BuiltList<InProgressCollection>>
              progresses) =>
      _$this._progresses = progresses;

  ProgressStateBuilder();

  ProgressStateBuilder get _$this {
    if (_$v != null) {
      _progresses = _$v.progresses?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProgressState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProgressState;
  }

  @override
  void update(void Function(ProgressStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProgressState build() {
    _$ProgressState _$result;
    try {
      _$result = _$v ?? new _$ProgressState._(progresses: progresses.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'progresses';
        progresses.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ProgressState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
