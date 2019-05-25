// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MutedGroup.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MutedGroup> _$mutedGroupSerializer = new _$MutedGroupSerializer();

class _$MutedGroupSerializer implements StructuredSerializer<MutedGroup> {
  @override
  final Iterable<Type> types = const [MutedGroup, _$MutedGroup];
  @override
  final String wireName = 'MutedGroup';

  @override
  Iterable serialize(Serializers serializers, MutedGroup object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'groupNickname',
      serializers.serialize(object.groupNickname,
          specifiedType: const FullType(String)),
      'groupId',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
    ];
    if (object.groupIcon != null) {
      result
        ..add('groupIcon')
        ..add(serializers.serialize(object.groupIcon,
            specifiedType: const FullType(BangumiImage)));
    }

    return result;
  }

  @override
  MutedGroup deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MutedGroupBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'groupNickname':
          result.groupNickname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'groupId':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'groupIcon':
          result.groupIcon.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
          break;
      }
    }

    return result.build();
  }
}

class _$MutedGroup extends MutedGroup {
  @override
  final String groupNickname;
  @override
  final String groupId;
  @override
  final BangumiImage groupIcon;

  factory _$MutedGroup([void Function(MutedGroupBuilder) updates]) =>
      (new MutedGroupBuilder()..update(updates)).build();

  _$MutedGroup._({this.groupNickname, this.groupId, this.groupIcon})
      : super._() {
    if (groupNickname == null) {
      throw new BuiltValueNullFieldError('MutedGroup', 'groupNickname');
    }
    if (groupId == null) {
      throw new BuiltValueNullFieldError('MutedGroup', 'groupId');
    }
  }

  @override
  MutedGroup rebuild(void Function(MutedGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MutedGroupBuilder toBuilder() => new MutedGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MutedGroup &&
        groupNickname == other.groupNickname &&
        groupId == other.groupId &&
        groupIcon == other.groupIcon;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, groupNickname.hashCode), groupId.hashCode),
        groupIcon.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MutedGroup')
          ..add('groupNickname', groupNickname)
          ..add('groupId', groupId)
          ..add('groupIcon', groupIcon))
        .toString();
  }
}

class MutedGroupBuilder implements Builder<MutedGroup, MutedGroupBuilder> {
  _$MutedGroup _$v;

  String _groupNickname;
  String get groupNickname => _$this._groupNickname;
  set groupNickname(String groupNickname) =>
      _$this._groupNickname = groupNickname;

  String _groupId;
  String get groupId => _$this._groupId;
  set groupId(String groupId) => _$this._groupId = groupId;

  BangumiImageBuilder _groupIcon;
  BangumiImageBuilder get groupIcon =>
      _$this._groupIcon ??= new BangumiImageBuilder();
  set groupIcon(BangumiImageBuilder groupIcon) => _$this._groupIcon = groupIcon;

  MutedGroupBuilder();

  MutedGroupBuilder get _$this {
    if (_$v != null) {
      _groupNickname = _$v.groupNickname;
      _groupId = _$v.groupId;
      _groupIcon = _$v.groupIcon?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MutedGroup other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MutedGroup;
  }

  @override
  void update(void Function(MutedGroupBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MutedGroup build() {
    _$MutedGroup _$result;
    try {
      _$result = _$v ??
          new _$MutedGroup._(
              groupNickname: groupNickname,
              groupId: groupId,
              groupIcon: _groupIcon?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'groupIcon';
        _groupIcon?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MutedGroup', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
