// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NetworkServiceTagPlainText.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NetworkServiceTagPlainText> _$networkServiceTagPlainTextSerializer =
    new _$NetworkServiceTagPlainTextSerializer();

class _$NetworkServiceTagPlainTextSerializer
    implements StructuredSerializer<NetworkServiceTagPlainText> {
  @override
  final Iterable<Type> types = const [
    NetworkServiceTagPlainText,
    _$NetworkServiceTagPlainText
  ];
  @override
  final String wireName = 'NetworkServiceTagPlainText';

  @override
  Iterable serialize(Serializers serializers, NetworkServiceTagPlainText object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
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
  NetworkServiceTagPlainText deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NetworkServiceTagPlainTextBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
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

class _$NetworkServiceTagPlainText extends NetworkServiceTagPlainText {
  @override
  final NetworkServiceType type;
  @override
  final String content;
  @override
  final bool isLink;

  factory _$NetworkServiceTagPlainText(
          [void Function(NetworkServiceTagPlainTextBuilder) updates]) =>
      (new NetworkServiceTagPlainTextBuilder()..update(updates)).build();

  _$NetworkServiceTagPlainText._({this.type, this.content, this.isLink})
      : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('NetworkServiceTagPlainText', 'type');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError(
          'NetworkServiceTagPlainText', 'content');
    }
    if (isLink == null) {
      throw new BuiltValueNullFieldError(
          'NetworkServiceTagPlainText', 'isLink');
    }
  }

  @override
  NetworkServiceTagPlainText rebuild(
          void Function(NetworkServiceTagPlainTextBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkServiceTagPlainTextBuilder toBuilder() =>
      new NetworkServiceTagPlainTextBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkServiceTagPlainText &&
        type == other.type &&
        content == other.content &&
        isLink == other.isLink;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, type.hashCode), content.hashCode), isLink.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NetworkServiceTagPlainText')
          ..add('type', type)
          ..add('content', content)
          ..add('isLink', isLink))
        .toString();
  }
}

class NetworkServiceTagPlainTextBuilder
    implements
        Builder<NetworkServiceTagPlainText, NetworkServiceTagPlainTextBuilder>,
        NetworkServiceTagBuilder {
  _$NetworkServiceTagPlainText _$v;

  NetworkServiceType _type;
  NetworkServiceType get type => _$this._type;
  set type(NetworkServiceType type) => _$this._type = type;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  bool _isLink;
  bool get isLink => _$this._isLink;
  set isLink(bool isLink) => _$this._isLink = isLink;

  NetworkServiceTagPlainTextBuilder();

  NetworkServiceTagPlainTextBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _content = _$v.content;
      _isLink = _$v.isLink;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant NetworkServiceTagPlainText other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NetworkServiceTagPlainText;
  }

  @override
  void update(void Function(NetworkServiceTagPlainTextBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NetworkServiceTagPlainText build() {
    final _$result = _$v ??
        new _$NetworkServiceTagPlainText._(
            type: type, content: content, isLink: isLink);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
