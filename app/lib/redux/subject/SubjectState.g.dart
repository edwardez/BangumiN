// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectState.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectState> _$subjectStateSerializer =
    new _$SubjectStateSerializer();

class _$SubjectStateSerializer implements StructuredSerializer<SubjectState> {
  @override
  final Iterable<Type> types = const [SubjectState, _$SubjectState];
  @override
  final String wireName = 'SubjectState';

  @override
  Iterable serialize(Serializers serializers, SubjectState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.subjects != null) {
      result
        ..add('subjects')
        ..add(serializers.serialize(object.subjects,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(int), const FullType(Subject)])));
    }

    return result;
  }

  @override
  SubjectState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'subjects':
          result.subjects.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(int),
                const FullType(Subject)
              ])) as BuiltMap);
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectState extends SubjectState {
  @override
  final BuiltMap<int, Subject> subjects;

  factory _$SubjectState([void updates(SubjectStateBuilder b)]) =>
      (new SubjectStateBuilder()..update(updates)).build();

  _$SubjectState._({this.subjects}) : super._();

  @override
  SubjectState rebuild(void updates(SubjectStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectStateBuilder toBuilder() => new SubjectStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectState && subjects == other.subjects;
  }

  @override
  int get hashCode {
    return $jf($jc(0, subjects.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectState')
          ..add('subjects', subjects))
        .toString();
  }
}

class SubjectStateBuilder
    implements Builder<SubjectState, SubjectStateBuilder> {
  _$SubjectState _$v;

  MapBuilder<int, Subject> _subjects;
  MapBuilder<int, Subject> get subjects =>
      _$this._subjects ??= new MapBuilder<int, Subject>();
  set subjects(MapBuilder<int, Subject> subjects) =>
      _$this._subjects = subjects;

  SubjectStateBuilder();

  SubjectStateBuilder get _$this {
    if (_$v != null) {
      _subjects = _$v.subjects?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectState;
  }

  @override
  void update(void updates(SubjectStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectState build() {
    _$SubjectState _$result;
    try {
      _$result = _$v ?? new _$SubjectState._(subjects: _subjects?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subjects';
        _subjects?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubjectState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
