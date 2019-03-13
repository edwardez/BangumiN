// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HyperImage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HyperImage extends HyperImage {
  @override
  final int id;
  @override
  final BangumiContent contentType;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final String link;

  factory _$HyperImage([void updates(HyperImageBuilder b)]) =>
      (new HyperImageBuilder()..update(updates)).build();

  _$HyperImage._(
      {this.id, this.contentType, this.name, this.imageUrl, this.link})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('HyperImage', 'id');
    }
    if (contentType == null) {
      throw new BuiltValueNullFieldError('HyperImage', 'contentType');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('HyperImage', 'name');
    }
    if (imageUrl == null) {
      throw new BuiltValueNullFieldError('HyperImage', 'imageUrl');
    }
  }

  @override
  HyperImage rebuild(void updates(HyperImageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HyperImageBuilder toBuilder() => new HyperImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HyperImage &&
        id == other.id &&
        contentType == other.contentType &&
        name == other.name &&
        imageUrl == other.imageUrl &&
        link == other.link;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), contentType.hashCode), name.hashCode),
            imageUrl.hashCode),
        link.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HyperImage')
          ..add('id', id)
          ..add('contentType', contentType)
          ..add('name', name)
          ..add('imageUrl', imageUrl)
          ..add('link', link))
        .toString();
  }
}

class HyperImageBuilder implements Builder<HyperImage, HyperImageBuilder> {
  _$HyperImage _$v;

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

  String _imageUrl;

  String get imageUrl => _$this._imageUrl;

  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _link;

  String get link => _$this._link;

  set link(String link) => _$this._link = link;

  HyperImageBuilder();

  HyperImageBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _contentType = _$v.contentType;
      _name = _$v.name;
      _imageUrl = _$v.imageUrl;
      _link = _$v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HyperImage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HyperImage;
  }

  @override
  void update(void updates(HyperImageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$HyperImage build() {
    final _$result = _$v ??
        new _$HyperImage._(
            id: id,
            contentType: contentType,
            name: name,
            imageUrl: imageUrl,
            link: link);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
