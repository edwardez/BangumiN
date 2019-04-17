// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DiscussionItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DiscussionItem> _$discussionItemSerializer =
    new _$DiscussionItemSerializer();

class _$DiscussionItemSerializer
    implements StructuredSerializer<DiscussionItem> {
  @override
  final Iterable<Type> types = const [DiscussionItem, _$DiscussionItem];
  @override
  final String wireName = 'DiscussionItem';

  @override
  Iterable serialize(Serializers serializers, DiscussionItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
      'images',
      serializers.serialize(object.images,
          specifiedType: const FullType(Images)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'subTitle',
      serializers.serialize(object.subTitle,
          specifiedType: const FullType(String)),
      'replyCount',
      serializers.serialize(object.replyCount,
          specifiedType: const FullType(int)),
    ];
    if (object.updatedAt != null) {
      result
        ..add('updatedAt')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  DiscussionItem deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DiscussionItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'bangumiContent':
          result.bangumiContent = serializers.deserialize(value,
              specifiedType: const FullType(BangumiContent)) as BangumiContent;
          break;
        case 'images':
          result.images.replace(serializers.deserialize(value,
              specifiedType: const FullType(Images)) as Images);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subTitle':
          result.subTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'replyCount':
          result.replyCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$DiscussionItem extends DiscussionItem {
  @override
  final int id;
  @override
  final BangumiContent bangumiContent;
  @override
  final Images images;
  @override
  final String title;
  @override
  final String subTitle;
  @override
  final int replyCount;
  @override
  final int updatedAt;

  factory _$DiscussionItem([void Function(DiscussionItemBuilder) updates]) =>
      (new DiscussionItemBuilder()..update(updates)).build();

  _$DiscussionItem._(
      {this.id,
      this.bangumiContent,
      this.images,
      this.title,
      this.subTitle,
      this.replyCount,
      this.updatedAt})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('DiscussionItem', 'id');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError('DiscussionItem', 'bangumiContent');
    }
    if (images == null) {
      throw new BuiltValueNullFieldError('DiscussionItem', 'images');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('DiscussionItem', 'title');
    }
    if (subTitle == null) {
      throw new BuiltValueNullFieldError('DiscussionItem', 'subTitle');
    }
    if (replyCount == null) {
      throw new BuiltValueNullFieldError('DiscussionItem', 'replyCount');
    }
  }

  @override
  DiscussionItem rebuild(void Function(DiscussionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiscussionItemBuilder toBuilder() =>
      new DiscussionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiscussionItem &&
        id == other.id &&
        bangumiContent == other.bangumiContent &&
        images == other.images &&
        title == other.title &&
        subTitle == other.subTitle &&
        replyCount == other.replyCount &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), bangumiContent.hashCode),
                        images.hashCode),
                    title.hashCode),
                subTitle.hashCode),
            replyCount.hashCode),
        updatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DiscussionItem')
          ..add('id', id)
          ..add('bangumiContent', bangumiContent)
          ..add('images', images)
          ..add('title', title)
          ..add('subTitle', subTitle)
          ..add('replyCount', replyCount)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class DiscussionItemBuilder
    implements Builder<DiscussionItem, DiscussionItemBuilder> {
  _$DiscussionItem _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  ImagesBuilder _images;
  ImagesBuilder get images => _$this._images ??= new ImagesBuilder();
  set images(ImagesBuilder images) => _$this._images = images;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _subTitle;
  String get subTitle => _$this._subTitle;
  set subTitle(String subTitle) => _$this._subTitle = subTitle;

  int _replyCount;
  int get replyCount => _$this._replyCount;
  set replyCount(int replyCount) => _$this._replyCount = replyCount;

  int _updatedAt;
  int get updatedAt => _$this._updatedAt;
  set updatedAt(int updatedAt) => _$this._updatedAt = updatedAt;

  DiscussionItemBuilder();

  DiscussionItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _bangumiContent = _$v.bangumiContent;
      _images = _$v.images?.toBuilder();
      _title = _$v.title;
      _subTitle = _$v.subTitle;
      _replyCount = _$v.replyCount;
      _updatedAt = _$v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DiscussionItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DiscussionItem;
  }

  @override
  void update(void Function(DiscussionItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DiscussionItem build() {
    _$DiscussionItem _$result;
    try {
      _$result = _$v ??
          new _$DiscussionItem._(
              id: id,
              bangumiContent: bangumiContent,
              images: images.build(),
              title: title,
              subTitle: subTitle,
              replyCount: replyCount,
              updatedAt: updatedAt);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        images.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DiscussionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
