// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FullPublicMessage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FullPublicMessage> _$fullPublicMessageSerializer =
    new _$FullPublicMessageSerializer();

class _$FullPublicMessageSerializer
    implements StructuredSerializer<FullPublicMessage> {
  @override
  final Iterable<Type> types = const [FullPublicMessage, _$FullPublicMessage];
  @override
  final String wireName = 'FullPublicMessage';

  @override
  Iterable<Object> serialize(Serializers serializers, FullPublicMessage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'mainMessage',
      serializers.serialize(object.mainMessage,
          specifiedType: const FullType(PublicMessageNormal)),
      'replies',
      serializers.serialize(object.replies,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PublicMessageReply)])),
    ];

    return result;
  }

  @override
  FullPublicMessage deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FullPublicMessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'mainMessage':
          result.mainMessage.replace(serializers.deserialize(value,
                  specifiedType: const FullType(PublicMessageNormal))
              as PublicMessageNormal);
          break;
        case 'replies':
          result.replies.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PublicMessageReply)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$FullPublicMessage extends FullPublicMessage {
  @override
  final PublicMessageNormal mainMessage;
  @override
  final BuiltList<PublicMessageReply> replies;

  factory _$FullPublicMessage(
          [void Function(FullPublicMessageBuilder) updates]) =>
      (new FullPublicMessageBuilder()..update(updates)).build();

  _$FullPublicMessage._({this.mainMessage, this.replies}) : super._() {
    if (mainMessage == null) {
      throw new BuiltValueNullFieldError('FullPublicMessage', 'mainMessage');
    }
    if (replies == null) {
      throw new BuiltValueNullFieldError('FullPublicMessage', 'replies');
    }
  }

  @override
  FullPublicMessage rebuild(void Function(FullPublicMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FullPublicMessageBuilder toBuilder() =>
      new FullPublicMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FullPublicMessage &&
        mainMessage == other.mainMessage &&
        replies == other.replies;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, mainMessage.hashCode), replies.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FullPublicMessage')
          ..add('mainMessage', mainMessage)
          ..add('replies', replies))
        .toString();
  }
}

class FullPublicMessageBuilder
    implements Builder<FullPublicMessage, FullPublicMessageBuilder> {
  _$FullPublicMessage _$v;

  PublicMessageNormalBuilder _mainMessage;
  PublicMessageNormalBuilder get mainMessage =>
      _$this._mainMessage ??= new PublicMessageNormalBuilder();
  set mainMessage(PublicMessageNormalBuilder mainMessage) =>
      _$this._mainMessage = mainMessage;

  ListBuilder<PublicMessageReply> _replies;
  ListBuilder<PublicMessageReply> get replies =>
      _$this._replies ??= new ListBuilder<PublicMessageReply>();
  set replies(ListBuilder<PublicMessageReply> replies) =>
      _$this._replies = replies;

  FullPublicMessageBuilder();

  FullPublicMessageBuilder get _$this {
    if (_$v != null) {
      _mainMessage = _$v.mainMessage?.toBuilder();
      _replies = _$v.replies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FullPublicMessage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FullPublicMessage;
  }

  @override
  void update(void Function(FullPublicMessageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FullPublicMessage build() {
    _$FullPublicMessage _$result;
    try {
      _$result = _$v ??
          new _$FullPublicMessage._(
              mainMessage: mainMessage.build(), replies: replies.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'mainMessage';
        mainMessage.build();
        _$failedField = 'replies';
        replies.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FullPublicMessage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
