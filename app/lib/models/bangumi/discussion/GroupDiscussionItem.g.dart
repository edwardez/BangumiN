// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GroupDiscussionItem.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GroupDiscussionItem> _$groupDiscussionItemSerializer =
    new _$GroupDiscussionItemSerializer();

class _$GroupDiscussionItemSerializer
    implements StructuredSerializer<GroupDiscussionItem> {
  @override
  final Iterable<Type> types = const [
    GroupDiscussionItem,
    _$GroupDiscussionItem
  ];
  @override
  final String wireName = 'GroupDiscussionItem';

  @override
  Iterable<Object> serialize(
      Serializers serializers, GroupDiscussionItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'postedGroupId',
      serializers.serialize(object.postedGroupId,
          specifiedType: const FullType(String)),
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
    if (object.originalPosterUsername != null) {
      result
        ..add('originalPosterUsername')
        ..add(serializers.serialize(object.originalPosterUsername,
            specifiedType: const FullType(String)));
    }
    if (object.originalPosterUserId != null) {
      result
        ..add('originalPosterUserId')
        ..add(serializers.serialize(object.originalPosterUserId,
            specifiedType: const FullType(int)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updatedAt')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GroupDiscussionItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupDiscussionItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'originalPosterUsername':
          result.originalPosterUsername = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'originalPosterUserId':
          result.originalPosterUserId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'postedGroupId':
          result.postedGroupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
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

class _$GroupDiscussionItem extends GroupDiscussionItem {
  @override
  final String originalPosterUsername;
  @override
  final int originalPosterUserId;
  @override
  final String postedGroupId;
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

  factory _$GroupDiscussionItem(
          [void Function(GroupDiscussionItemBuilder) updates]) =>
      (new GroupDiscussionItemBuilder()..update(updates)).build();

  _$GroupDiscussionItem._(
      {this.originalPosterUsername,
      this.originalPosterUserId,
      this.postedGroupId,
      this.id,
      this.bangumiContent,
      this.image,
      this.title,
      this.subTitle,
      this.replyCount,
      this.updatedAt})
      : super._() {
    if (postedGroupId == null) {
      throw new BuiltValueNullFieldError(
          'GroupDiscussionItem', 'postedGroupId');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('GroupDiscussionItem', 'id');
    }
    if (bangumiContent == null) {
      throw new BuiltValueNullFieldError(
          'GroupDiscussionItem', 'bangumiContent');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('GroupDiscussionItem', 'image');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('GroupDiscussionItem', 'title');
    }
    if (subTitle == null) {
      throw new BuiltValueNullFieldError('GroupDiscussionItem', 'subTitle');
    }
    if (replyCount == null) {
      throw new BuiltValueNullFieldError('GroupDiscussionItem', 'replyCount');
    }
  }

  @override
  GroupDiscussionItem rebuild(
          void Function(GroupDiscussionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupDiscussionItemBuilder toBuilder() =>
      new GroupDiscussionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupDiscussionItem &&
        originalPosterUsername == other.originalPosterUsername &&
        originalPosterUserId == other.originalPosterUserId &&
        postedGroupId == other.postedGroupId &&
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
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, originalPosterUsername.hashCode),
                                        originalPosterUserId.hashCode),
                                    postedGroupId.hashCode),
                                id.hashCode),
                            bangumiContent.hashCode),
                        image.hashCode),
                    title.hashCode),
                subTitle.hashCode),
            replyCount.hashCode),
        updatedAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupDiscussionItem')
          ..add('originalPosterUsername', originalPosterUsername)
          ..add('originalPosterUserId', originalPosterUserId)
          ..add('postedGroupId', postedGroupId)
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

class GroupDiscussionItemBuilder
    implements
        Builder<GroupDiscussionItem, GroupDiscussionItemBuilder>,
        DiscussionItemBuilder {
  _$GroupDiscussionItem _$v;

  String _originalPosterUsername;
  String get originalPosterUsername => _$this._originalPosterUsername;
  set originalPosterUsername(String originalPosterUsername) =>
      _$this._originalPosterUsername = originalPosterUsername;

  int _originalPosterUserId;
  int get originalPosterUserId => _$this._originalPosterUserId;
  set originalPosterUserId(int originalPosterUserId) =>
      _$this._originalPosterUserId = originalPosterUserId;

  String _postedGroupId;
  String get postedGroupId => _$this._postedGroupId;
  set postedGroupId(String postedGroupId) =>
      _$this._postedGroupId = postedGroupId;

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

  GroupDiscussionItemBuilder();

  GroupDiscussionItemBuilder get _$this {
    if (_$v != null) {
      _originalPosterUsername = _$v.originalPosterUsername;
      _originalPosterUserId = _$v.originalPosterUserId;
      _postedGroupId = _$v.postedGroupId;
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
  void replace(covariant GroupDiscussionItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GroupDiscussionItem;
  }

  @override
  void update(void Function(GroupDiscussionItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupDiscussionItem build() {
    _$GroupDiscussionItem _$result;
    try {
      _$result = _$v ??
          new _$GroupDiscussionItem._(
              originalPosterUsername: originalPosterUsername,
              originalPosterUserId: originalPosterUserId,
              postedGroupId: postedGroupId,
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
            'GroupDiscussionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
