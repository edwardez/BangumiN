// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeneralSetting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GeneralSetting> _$generalSettingSerializer =
    new _$GeneralSettingSerializer();

class _$GeneralSettingSerializer
    implements StructuredSerializer<GeneralSetting> {
  @override
  final Iterable<Type> types = const [GeneralSetting, _$GeneralSetting];
  @override
  final String wireName = 'GeneralSetting';

  @override
  Iterable serialize(Serializers serializers, GeneralSetting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'preferredTimelineLaunchPage',
      serializers.serialize(object.preferredTimelineLaunchPage,
          specifiedType: const FullType(TimelineCategoryFilter)),
      'preferredProgressLaunchPage',
      serializers.serialize(object.preferredProgressLaunchPage,
          specifiedType: const FullType(GetProgressRequest)),
      'preferredDiscussionLaunchPage',
      serializers.serialize(object.preferredDiscussionLaunchPage,
          specifiedType: const FullType(GetDiscussionRequest)),
    ];
    if (object.preferredLaunchNavTab != null) {
      result
        ..add('preferredLaunchNavTab')
        ..add(serializers.serialize(object.preferredLaunchNavTab,
            specifiedType: const FullType(PreferredLaunchNavTab)));
    }

    return result;
  }

  @override
  GeneralSetting deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeneralSettingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'preferredLaunchNavTab':
          result.preferredLaunchNavTab = serializers.deserialize(value,
                  specifiedType: const FullType(PreferredLaunchNavTab))
              as PreferredLaunchNavTab;
          break;
        case 'preferredTimelineLaunchPage':
          result.preferredTimelineLaunchPage = serializers.deserialize(value,
                  specifiedType: const FullType(TimelineCategoryFilter))
              as TimelineCategoryFilter;
          break;
        case 'preferredProgressLaunchPage':
          result.preferredProgressLaunchPage.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(GetProgressRequest))
              as GetProgressRequest);
          break;
        case 'preferredDiscussionLaunchPage':
          result.preferredDiscussionLaunchPage.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(GetDiscussionRequest))
              as GetDiscussionRequest);
          break;
      }
    }

    return result.build();
  }
}

class _$GeneralSetting extends GeneralSetting {
  @override
  final PreferredLaunchNavTab preferredLaunchNavTab;
  @override
  final TimelineCategoryFilter preferredTimelineLaunchPage;
  @override
  final GetProgressRequest preferredProgressLaunchPage;
  @override
  final GetDiscussionRequest preferredDiscussionLaunchPage;

  factory _$GeneralSetting([void Function(GeneralSettingBuilder) updates]) =>
      (new GeneralSettingBuilder()..update(updates)).build();

  _$GeneralSetting._(
      {this.preferredLaunchNavTab,
      this.preferredTimelineLaunchPage,
      this.preferredProgressLaunchPage,
      this.preferredDiscussionLaunchPage})
      : super._() {
    if (preferredTimelineLaunchPage == null) {
      throw new BuiltValueNullFieldError(
          'GeneralSetting', 'preferredTimelineLaunchPage');
    }
    if (preferredProgressLaunchPage == null) {
      throw new BuiltValueNullFieldError(
          'GeneralSetting', 'preferredProgressLaunchPage');
    }
    if (preferredDiscussionLaunchPage == null) {
      throw new BuiltValueNullFieldError(
          'GeneralSetting', 'preferredDiscussionLaunchPage');
    }
  }

  @override
  GeneralSetting rebuild(void Function(GeneralSettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralSettingBuilder toBuilder() =>
      new GeneralSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralSetting &&
        preferredLaunchNavTab == other.preferredLaunchNavTab &&
        preferredTimelineLaunchPage == other.preferredTimelineLaunchPage &&
        preferredProgressLaunchPage == other.preferredProgressLaunchPage &&
        preferredDiscussionLaunchPage == other.preferredDiscussionLaunchPage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc(0, preferredLaunchNavTab.hashCode),
                preferredTimelineLaunchPage.hashCode),
            preferredProgressLaunchPage.hashCode),
        preferredDiscussionLaunchPage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GeneralSetting')
          ..add('preferredLaunchNavTab', preferredLaunchNavTab)
          ..add('preferredTimelineLaunchPage', preferredTimelineLaunchPage)
          ..add('preferredProgressLaunchPage', preferredProgressLaunchPage)
          ..add('preferredDiscussionLaunchPage', preferredDiscussionLaunchPage))
        .toString();
  }
}

class GeneralSettingBuilder
    implements Builder<GeneralSetting, GeneralSettingBuilder> {
  _$GeneralSetting _$v;

  PreferredLaunchNavTab _preferredLaunchNavTab;
  PreferredLaunchNavTab get preferredLaunchNavTab =>
      _$this._preferredLaunchNavTab;
  set preferredLaunchNavTab(PreferredLaunchNavTab preferredLaunchNavTab) =>
      _$this._preferredLaunchNavTab = preferredLaunchNavTab;

  TimelineCategoryFilter _preferredTimelineLaunchPage;
  TimelineCategoryFilter get preferredTimelineLaunchPage =>
      _$this._preferredTimelineLaunchPage;
  set preferredTimelineLaunchPage(
          TimelineCategoryFilter preferredTimelineLaunchPage) =>
      _$this._preferredTimelineLaunchPage = preferredTimelineLaunchPage;

  GetProgressRequestBuilder _preferredProgressLaunchPage;
  GetProgressRequestBuilder get preferredProgressLaunchPage =>
      _$this._preferredProgressLaunchPage ??= new GetProgressRequestBuilder();
  set preferredProgressLaunchPage(
          GetProgressRequestBuilder preferredProgressLaunchPage) =>
      _$this._preferredProgressLaunchPage = preferredProgressLaunchPage;

  GetDiscussionRequestBuilder _preferredDiscussionLaunchPage;
  GetDiscussionRequestBuilder get preferredDiscussionLaunchPage =>
      _$this._preferredDiscussionLaunchPage ??=
          new GetDiscussionRequestBuilder();
  set preferredDiscussionLaunchPage(
          GetDiscussionRequestBuilder preferredDiscussionLaunchPage) =>
      _$this._preferredDiscussionLaunchPage = preferredDiscussionLaunchPage;

  GeneralSettingBuilder();

  GeneralSettingBuilder get _$this {
    if (_$v != null) {
      _preferredLaunchNavTab = _$v.preferredLaunchNavTab;
      _preferredTimelineLaunchPage = _$v.preferredTimelineLaunchPage;
      _preferredProgressLaunchPage =
          _$v.preferredProgressLaunchPage?.toBuilder();
      _preferredDiscussionLaunchPage =
          _$v.preferredDiscussionLaunchPage?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneralSetting other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GeneralSetting;
  }

  @override
  void update(void Function(GeneralSettingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GeneralSetting build() {
    _$GeneralSetting _$result;
    try {
      _$result = _$v ??
          new _$GeneralSetting._(
              preferredLaunchNavTab: preferredLaunchNavTab,
              preferredTimelineLaunchPage: preferredTimelineLaunchPage,
              preferredProgressLaunchPage: preferredProgressLaunchPage.build(),
              preferredDiscussionLaunchPage:
                  preferredDiscussionLaunchPage.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'preferredProgressLaunchPage';
        preferredProgressLaunchPage.build();
        _$failedField = 'preferredDiscussionLaunchPage';
        preferredDiscussionLaunchPage.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GeneralSetting', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
