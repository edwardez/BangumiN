// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HyperBangumiItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HyperBangumiItem extends HyperBangumiItem {
  @override
  final int id;
  @override
  final BangumiContent contentType;
  @override
  final String name;
  @override
  final String link;
  @override
  final String imageUrl;

  factory _$HyperBangumiItem([void updates(HyperBangumiItemBuilder b)]) =>
      (new HyperBangumiItemBuilder()..update(updates)).build();

  _$HyperBangumiItem._(
      {this.id, this.contentType, this.name, this.link, this.imageUrl})
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
        link == other.link &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), contentType.hashCode), name.hashCode),
            link.hashCode),
        imageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HyperBangumiItem')
          ..add('id', id)
          ..add('contentType', contentType)
          ..add('name', name)
          ..add('link', link)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class HyperBangumiItemBuilder
    implements Builder<HyperBangumiItem, HyperBangumiItemBuilder> {
  _$HyperBangumiItem _$v;

  int _id;

  int get id => _$this._id;

  set id(int id) => _$this._id = id;

  BangumiContent _contentType;

  BangumiContent get contentType => _$this._contentType;

  set contentType(BangumiContent contentType) =>
      _$this._contentType = contentType;

  String _name;

  String get name => _$this._name;

  set name(String name) => _$this._name = name;

  String _link;

  String get link => _$this._link;

  set link(String link) => _$this._link = link;

  String _imageUrl;

  String get imageUrl => _$this._imageUrl;

  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  HyperBangumiItemBuilder();

  HyperBangumiItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _contentType = _$v.contentType;
      _name = _$v.name;
      _link = _$v.link;
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
            link: link,
            imageUrl: imageUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
