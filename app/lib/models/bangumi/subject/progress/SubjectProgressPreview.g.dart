// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectProgressPreview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubjectProgressPreview> _$subjectProgressPreviewSerializer =
    new _$SubjectProgressPreviewSerializer();

class _$SubjectProgressPreviewSerializer
    implements StructuredSerializer<SubjectProgressPreview> {
  @override
  final Iterable<Type> types = const [
    SubjectProgressPreview,
    _$SubjectProgressPreview
  ];
  @override
  final String wireName = 'SubjectProgressPreview';

  @override
  Iterable serialize(Serializers serializers, SubjectProgressPreview object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.completedEpisodesCount != null) {
      result
        ..add('completedEpisodesCount')
        ..add(serializers.serialize(object.completedEpisodesCount,
            specifiedType: const FullType(int)));
    }
    if (object.completedVolumesCount != null) {
      result
        ..add('completedVolumesCount')
        ..add(serializers.serialize(object.completedVolumesCount,
            specifiedType: const FullType(int)));
    }
    if (object.totalEpisodesCount != null) {
      result
        ..add('totalEpisodesCount')
        ..add(serializers.serialize(object.totalEpisodesCount,
            specifiedType: const FullType(int)));
    }
    if (object.totalVolumesCount != null) {
      result
        ..add('totalVolumesCount')
        ..add(serializers.serialize(object.totalVolumesCount,
            specifiedType: const FullType(int)));
    }
    if (object.isTankobon != null) {
      result
        ..add('isTankobon')
        ..add(serializers.serialize(object.isTankobon,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  SubjectProgressPreview deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubjectProgressPreviewBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'completedEpisodesCount':
          result.completedEpisodesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'completedVolumesCount':
          result.completedVolumesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'totalEpisodesCount':
          result.totalEpisodesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'totalVolumesCount':
          result.totalVolumesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isTankobon':
          result.isTankobon = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SubjectProgressPreview extends SubjectProgressPreview {
  @override
  final int completedEpisodesCount;
  @override
  final int completedVolumesCount;
  @override
  final int totalEpisodesCount;
  @override
  final int totalVolumesCount;
  @override
  final bool isTankobon;

  factory _$SubjectProgressPreview(
          [void Function(SubjectProgressPreviewBuilder) updates]) =>
      (new SubjectProgressPreviewBuilder()..update(updates)).build();

  _$SubjectProgressPreview._(
      {this.completedEpisodesCount,
      this.completedVolumesCount,
      this.totalEpisodesCount,
      this.totalVolumesCount,
      this.isTankobon})
      : super._();

  @override
  SubjectProgressPreview rebuild(
          void Function(SubjectProgressPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubjectProgressPreviewBuilder toBuilder() =>
      new SubjectProgressPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubjectProgressPreview &&
        completedEpisodesCount == other.completedEpisodesCount &&
        completedVolumesCount == other.completedVolumesCount &&
        totalEpisodesCount == other.totalEpisodesCount &&
        totalVolumesCount == other.totalVolumesCount &&
        isTankobon == other.isTankobon;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc(0, completedEpisodesCount.hashCode),
                    completedVolumesCount.hashCode),
                totalEpisodesCount.hashCode),
            totalVolumesCount.hashCode),
        isTankobon.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubjectProgressPreview')
          ..add('completedEpisodesCount', completedEpisodesCount)
          ..add('completedVolumesCount', completedVolumesCount)
          ..add('totalEpisodesCount', totalEpisodesCount)
          ..add('totalVolumesCount', totalVolumesCount)
          ..add('isTankobon', isTankobon))
        .toString();
  }
}

class SubjectProgressPreviewBuilder
    implements Builder<SubjectProgressPreview, SubjectProgressPreviewBuilder> {
  _$SubjectProgressPreview _$v;

  int _completedEpisodesCount;
  int get completedEpisodesCount => _$this._completedEpisodesCount;
  set completedEpisodesCount(int completedEpisodesCount) =>
      _$this._completedEpisodesCount = completedEpisodesCount;

  int _completedVolumesCount;
  int get completedVolumesCount => _$this._completedVolumesCount;
  set completedVolumesCount(int completedVolumesCount) =>
      _$this._completedVolumesCount = completedVolumesCount;

  int _totalEpisodesCount;
  int get totalEpisodesCount => _$this._totalEpisodesCount;
  set totalEpisodesCount(int totalEpisodesCount) =>
      _$this._totalEpisodesCount = totalEpisodesCount;

  int _totalVolumesCount;
  int get totalVolumesCount => _$this._totalVolumesCount;
  set totalVolumesCount(int totalVolumesCount) =>
      _$this._totalVolumesCount = totalVolumesCount;

  bool _isTankobon;
  bool get isTankobon => _$this._isTankobon;
  set isTankobon(bool isTankobon) => _$this._isTankobon = isTankobon;

  SubjectProgressPreviewBuilder();

  SubjectProgressPreviewBuilder get _$this {
    if (_$v != null) {
      _completedEpisodesCount = _$v.completedEpisodesCount;
      _completedVolumesCount = _$v.completedVolumesCount;
      _totalEpisodesCount = _$v.totalEpisodesCount;
      _totalVolumesCount = _$v.totalVolumesCount;
      _isTankobon = _$v.isTankobon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubjectProgressPreview other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubjectProgressPreview;
  }

  @override
  void update(void Function(SubjectProgressPreviewBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubjectProgressPreview build() {
    final _$result = _$v ??
        new _$SubjectProgressPreview._(
            completedEpisodesCount: completedEpisodesCount,
            completedVolumesCount: completedVolumesCount,
            totalEpisodesCount: totalEpisodesCount,
            totalVolumesCount: totalVolumesCount,
            isTankobon: isTankobon);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
