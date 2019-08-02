// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkServiceTagLink.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NetworkServiceTagLink> _$networkServiceTagLinkSerializer =
    new _$NetworkServiceTagLinkSerializer();

class _$NetworkServiceTagLinkSerializer
    implements StructuredSerializer<NetworkServiceTagLink> {
  @override
  final Iterable<Type> types = const [
    NetworkServiceTagLink,
    _$NetworkServiceTagLink
  ];
  @override
  final String wireName = 'NetworkServiceTagLink';

  @override
  Iterable<Object> serialize(
      Serializers serializers, NetworkServiceTagLink object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'link',
      serializers.serialize(object.link, specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(NetworkServiceType)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'isLink',
      serializers.serialize(object.isLink, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  NetworkServiceTagLink deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NetworkServiceTagLinkBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'link':
          result.link = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(NetworkServiceType))
              as NetworkServiceType;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isLink':
          result.isLink = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$NetworkServiceTagLink extends NetworkServiceTagLink {
  @override
  final String link;
  @override
  final NetworkServiceType type;
  @override
  final String content;
  @override
  final bool isLink;

  factory _$NetworkServiceTagLink(
          [void Function(NetworkServiceTagLinkBuilder) updates]) =>
      (new NetworkServiceTagLinkBuilder()..update(updates)).build();

  _$NetworkServiceTagLink._({this.link, this.type, this.content, this.isLink})
      : super._() {
    if (link == null) {
      throw new BuiltValueNullFieldError('NetworkServiceTagLink', 'link');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('NetworkServiceTagLink', 'type');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('NetworkServiceTagLink', 'content');
    }
    if (isLink == null) {
      throw new BuiltValueNullFieldError('NetworkServiceTagLink', 'isLink');
    }
  }

  @override
  NetworkServiceTagLink rebuild(
          void Function(NetworkServiceTagLinkBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkServiceTagLinkBuilder toBuilder() =>
      new NetworkServiceTagLinkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkServiceTagLink &&
        link == other.link &&
        type == other.type &&
        content == other.content &&
        isLink == other.isLink;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, link.hashCode), type.hashCode), content.hashCode),
        isLink.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NetworkServiceTagLink')
          ..add('link', link)
          ..add('type', type)
          ..add('content', content)
          ..add('isLink', isLink))
        .toString();
  }
}

class NetworkServiceTagLinkBuilder
    implements
        Builder<NetworkServiceTagLink, NetworkServiceTagLinkBuilder>,
        NetworkServiceTagBuilder {
  _$NetworkServiceTagLink _$v;

  String _link;
  String get link => _$this._link;
  set link(String link) => _$this._link = link;

  NetworkServiceType _type;
  NetworkServiceType get type => _$this._type;
  set type(NetworkServiceType type) => _$this._type = type;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  bool _isLink;
  bool get isLink => _$this._isLink;
  set isLink(bool isLink) => _$this._isLink = isLink;

  NetworkServiceTagLinkBuilder();

  NetworkServiceTagLinkBuilder get _$this {
    if (_$v != null) {
      _link = _$v.link;
      _type = _$v.type;
      _content = _$v.content;
      _isLink = _$v.isLink;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant NetworkServiceTagLink other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NetworkServiceTagLink;
  }

  @override
  void update(void Function(NetworkServiceTagLinkBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NetworkServiceTagLink build() {
    final _$result = _$v ??
        new _$NetworkServiceTagLink._(
            link: link, type: type, content: content, isLink: isLink);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
