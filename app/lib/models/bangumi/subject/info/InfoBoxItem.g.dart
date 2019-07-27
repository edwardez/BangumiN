// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InfoBoxItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InfoBoxItem> _$infoBoxItemSerializer = new _$InfoBoxItemSerializer();

class _$InfoBoxItemSerializer implements StructuredSerializer<InfoBoxItem> {
  @override
  final Iterable<Type> types = const [InfoBoxItem, _$InfoBoxItem];
  @override
  final String wireName = 'InfoBoxItem';

  @override
  Iterable<Object> serialize(Serializers serializers, InfoBoxItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(BangumiContent)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.pageUrl != null) {
      result
        ..add('pageUrl')
        ..add(serializers.serialize(object.pageUrl,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  InfoBoxItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InfoBoxItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(BangumiContent)) as BangumiContent;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pageUrl':
          result.pageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$InfoBoxItem extends InfoBoxItem {
  @override
  final BangumiContent type;
  @override
  final String name;
  @override
  final String id;
  @override
  final String pageUrl;

  factory _$InfoBoxItem([void Function(InfoBoxItemBuilder) updates]) =>
      (new InfoBoxItemBuilder()..update(updates)).build();

  _$InfoBoxItem._({this.type, this.name, this.id, this.pageUrl}) : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('InfoBoxItem', 'type');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('InfoBoxItem', 'name');
    }
  }

  @override
  InfoBoxItem rebuild(void Function(InfoBoxItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InfoBoxItemBuilder toBuilder() => new InfoBoxItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InfoBoxItem &&
        type == other.type &&
        name == other.name &&
        id == other.id &&
        pageUrl == other.pageUrl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc($jc(0, type.hashCode), name.hashCode), id.hashCode),
        pageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InfoBoxItem')
          ..add('type', type)
          ..add('name', name)
          ..add('id', id)
          ..add('pageUrl', pageUrl))
        .toString();
  }
}

class InfoBoxItemBuilder implements Builder<InfoBoxItem, InfoBoxItemBuilder> {
  _$InfoBoxItem _$v;

  BangumiContent _type;
  BangumiContent get type => _$this._type;
  set type(BangumiContent type) => _$this._type = type;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _pageUrl;
  String get pageUrl => _$this._pageUrl;
  set pageUrl(String pageUrl) => _$this._pageUrl = pageUrl;

  InfoBoxItemBuilder();

  InfoBoxItemBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _name = _$v.name;
      _id = _$v.id;
      _pageUrl = _$v.pageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InfoBoxItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InfoBoxItem;
  }

  @override
  void update(void Function(InfoBoxItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InfoBoxItem build() {
    final _$result = _$v ??
        new _$InfoBoxItem._(type: type, name: name, id: id, pageUrl: pageUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
