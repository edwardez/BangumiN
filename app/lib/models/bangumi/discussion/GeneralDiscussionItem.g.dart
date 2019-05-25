// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeneralDiscussionItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GeneralDiscussionItem> _$generalDiscussionItemSerializer =
    new _$GeneralDiscussionItemSerializer();

class _$GeneralDiscussionItemSerializer
    implements StructuredSerializer<GeneralDiscussionItem> {
  @override
  final Iterable<Type> types = const [
    GeneralDiscussionItem,
    _$GeneralDiscussionItem
  ];
  @override
  final String wireName = 'GeneralDiscussionItem';

  @override
  Iterable serialize(Serializers serializers, GeneralDiscussionItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'bangumiContent',
      serializers.serialize(object.bangumiContent,
          specifiedType: const FullType(BangumiContent)),
      'image',
      serializers.serialize(object.image,
          specifiedType: const FullType(BangumiImage)),
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
  GeneralDiscussionItem deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeneralDiscussionItemBuilder();

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
        case 'image':
          result.image.replace(serializers.deserialize(value,
              specifiedType: const FullType(BangumiImage)) as BangumiImage);
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

class _$GeneralDiscussionItem extends GeneralDiscussionItem {
  @override
  final int id;
  @override
  final BangumiContent bangumiContent;
  @override
  final BangumiImage image;
  @override
  final String title;
  @override
  final String subTitle;
  @override
  final int replyCount;
  @override
  final int updatedAt;

  factory _$GeneralDiscussionItem(
          [void Function(GeneralDiscussionItemBuilder) updates]) =>
      (new GeneralDiscussionItemBuilder()..update(updates)).build();

  _$GeneralDiscussionItem._(
      {this.id,
      this.bangumiContent,
      this.image,
      this.title,
      this.subTitle,
      this.replyCount,
      this.updatedAt})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('GeneralDiscussionItem', 'id');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'GeneralDiscussionItem', 'bangumiContent');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('GeneralDiscussionItem', 'image');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('GeneralDiscussionItem', 'title');
    }
    if (subTitle == null) {
      throw new BuiltValueNullFieldError('GeneralDiscussionItem', 'subTitle');
    }
    if (replyCount == null) {
      throw new BuiltValueNullFieldError('GeneralDiscussionItem', 'replyCount');
    }
  }

  @override
  GeneralDiscussionItem rebuild(
          void Function(GeneralDiscussionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralDiscussionItemBuilder toBuilder() =>
      new GeneralDiscussionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralDiscussionItem &&
        id == other.id &&
        bangumiContent == other.bangumiContent &&
        image == other.image &&
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
                        image.hashCode),
                    title.hashCode),
                subTitle.hashCode),
            replyCount.hashCode),
        updatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GeneralDiscussionItem')
          ..add('id', id)
          ..add('bangumiContent', bangumiContent)
          ..add('image', image)
          ..add('title', title)
          ..add('subTitle', subTitle)
          ..add('replyCount', replyCount)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GeneralDiscussionItemBuilder
    implements
        Builder<GeneralDiscussionItem, GeneralDiscussionItemBuilder>,
        DiscussionItemBuilder {
  _$GeneralDiscussionItem _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  BangumiContent _bangumiContent;
  BangumiContent get bangumiContent => _$this._bangumiContent;
  set bangumiContent(BangumiContent bangumiContent) =>
      _$this._bangumiContent = bangumiContent;

  BangumiImageBuilder _image;
  BangumiImageBuilder get image => _$this._image ??= new BangumiImageBuilder();
  set image(BangumiImageBuilder image) => _$this._image = image;

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

  GeneralDiscussionItemBuilder();

  GeneralDiscussionItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _bangumiContent = _$v.bangumiContent;
      _image = _$v.image?.toBuilder();
      _title = _$v.title;
      _subTitle = _$v.subTitle;
      _replyCount = _$v.replyCount;
      _updatedAt = _$v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant GeneralDiscussionItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GeneralDiscussionItem;
  }

  @override
  void update(void Function(GeneralDiscussionItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GeneralDiscussionItem build() {
    _$GeneralDiscussionItem _$result;
    try {
      _$result = _$v ??
          new _$GeneralDiscussionItem._(
              id: id,
              bangumiContent: bangumiContent,
              image: image.build(),
              title: title,
              subTitle: subTitle,
              replyCount: replyCount,
              updatedAt: updatedAt);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'image';
        image.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GeneralDiscussionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
