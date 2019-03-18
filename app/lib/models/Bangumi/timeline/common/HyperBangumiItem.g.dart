// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HyperBangumiItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HyperBangumiItem> _$hyperBangumiItemSerializer =
new _$HyperBangumiItemSerializer();

class _$HyperBangumiItemSerializer
    implements StructuredSerializer<HyperBangumiItem> {
  @override
  final Iterable<Type> types = const [HyperBangumiItem, _$HyperBangumiItem];
  @override
  final String wireName = 'HyperBangumiItem';

  @override
  Iterable serialize(Serializers serializers, HyperBangumiItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'contentType',
      serializers.serialize(object.contentType,
          specifiedType: const FullType(BangumiContent)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];
    if (object.pageUrl != null) {
      result..add('pageUrl')..add(serializers.serialize(object.pageUrl,
          specifiedType: const FullType(String)));
    }
    if (object.imageUrl != null) {
      result..add('imageUrl')..add(serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  HyperBangumiItem deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HyperBangumiItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'contentType':
          result.contentType = serializers.deserialize(value,
              specifiedType: const FullType(BangumiContent)) as BangumiContent;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pageUrl':
          result.pageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$HyperBangumiItem extends HyperBangumiItem {
  @override
  final String id;
  @override
  final BangumiContent contentType;
  @override
  final String name;
  @override
  final String pageUrl;
  @override
  final String imageUrl;

  factory _$HyperBangumiItem([void updates(HyperBangumiItemBuilder b)]) =>
      (new HyperBangumiItemBuilder()..update(updates)).build();

  _$HyperBangumiItem._(
      {this.id, this.contentType, this.name, this.pageUrl, this.imageUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('HyperBangumiItem', 'id');
    }
    if (contentType == null) {
      throw new BuiltValueNullFieldError('HyperBangumiItem', 'contentType');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('HyperBangumiItem', 'name');
    }
  }

  @override
  HyperBangumiItem rebuild(void updates(HyperBangumiItemBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HyperBangumiItemBuilder toBuilder() =>
      new HyperBangumiItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HyperBangumiItem &&
        id == other.id &&
        contentType == other.contentType &&
        name == other.name &&
        pageUrl == other.pageUrl &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), contentType.hashCode), name.hashCode),
            pageUrl.hashCode),
        imageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HyperBangumiItem')
          ..add('id', id)
          ..add('contentType', contentType)
          ..add('name', name)..add('pageUrl', pageUrl)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class HyperBangumiItemBuilder
    implements Builder<HyperBangumiItem, HyperBangumiItemBuilder> {
  _$HyperBangumiItem _$v;

  String _id;

  String get id => _$this._id;

  set id(String id) => _$this._id = id;

  BangumiContent _contentType;
  BangumiContent get contentType => _$this._contentType;
  set contentType(BangumiContent contentType) =>
      _$this._contentType = contentType;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _pageUrl;

  String get pageUrl => _$this._pageUrl;

  set pageUrl(String pageUrl) => _$this._pageUrl = pageUrl;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  HyperBangumiItemBuilder();

  HyperBangumiItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _contentType = _$v.contentType;
      _name = _$v.name;
      _pageUrl = _$v.pageUrl;
      _imageUrl = _$v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HyperBangumiItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HyperBangumiItem;
  }

  @override
  void update(void updates(HyperBangumiItemBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$HyperBangumiItem build() {
    final _$result = _$v ??
        new _$HyperBangumiItem._(
            id: id,
            contentType: contentType,
            name: name,
            pageUrl: pageUrl,
            imageUrl: imageUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
