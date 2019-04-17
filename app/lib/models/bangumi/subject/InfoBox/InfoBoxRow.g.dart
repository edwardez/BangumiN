// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InfoBoxRow.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<InfoBoxRow> _$infoBoxRowSerializer = new _$InfoBoxRowSerializer();

class _$InfoBoxRowSerializer implements StructuredSerializer<InfoBoxRow> {
  @override
  final Iterable<Type> types = const [InfoBoxRow, _$InfoBoxRow];
  @override
  final String wireName = 'InfoBoxRow';

  @override
  Iterable serialize(Serializers serializers, InfoBoxRow object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'rowName',
      serializers.serialize(object.rowName,
          specifiedType: const FullType(String)),
      'isCuratedRow',
      serializers.serialize(object.isCuratedRow,
          specifiedType: const FullType(bool)),
      'rowItems',
      serializers.serialize(object.rowItems,
          specifiedType:
              const FullType(BuiltList, const [const FullType(InfoBoxItem)])),
    ];

    return result;
  }

  @override
  InfoBoxRow deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new InfoBoxRowBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'rowName':
          result.rowName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isCuratedRow':
          result.isCuratedRow = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'rowItems':
          result.rowItems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(InfoBoxItem)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$InfoBoxRow extends InfoBoxRow {
  @override
  final String rowName;
  @override
  final bool isCuratedRow;
  @override
  final BuiltList<InfoBoxItem> rowItems;

  factory _$InfoBoxRow([void Function(InfoBoxRowBuilder) updates]) =>
      (new InfoBoxRowBuilder()..update(updates)).build();

  _$InfoBoxRow._({this.rowName, this.isCuratedRow, this.rowItems}) : super._() {
    if (rowName == null) {
      throw new BuiltValueNullFieldError('InfoBoxRow', 'rowName');
    }
    if (isCuratedRow == null) {
      throw new BuiltValueNullFieldError('InfoBoxRow', 'isCuratedRow');
    }
    if (rowItems == null) {
      throw new BuiltValueNullFieldError('InfoBoxRow', 'rowItems');
    }
  }

  @override
  InfoBoxRow rebuild(void Function(InfoBoxRowBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InfoBoxRowBuilder toBuilder() => new InfoBoxRowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InfoBoxRow &&
        rowName == other.rowName &&
        isCuratedRow == other.isCuratedRow &&
        rowItems == other.rowItems;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, rowName.hashCode), isCuratedRow.hashCode),
        rowItems.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('InfoBoxRow')
          ..add('rowName', rowName)
          ..add('isCuratedRow', isCuratedRow)
          ..add('rowItems', rowItems))
        .toString();
  }
}

class InfoBoxRowBuilder implements Builder<InfoBoxRow, InfoBoxRowBuilder> {
  _$InfoBoxRow _$v;

  String _rowName;
  String get rowName => _$this._rowName;
  set rowName(String rowName) => _$this._rowName = rowName;

  bool _isCuratedRow;
  bool get isCuratedRow => _$this._isCuratedRow;
  set isCuratedRow(bool isCuratedRow) => _$this._isCuratedRow = isCuratedRow;

  ListBuilder<InfoBoxItem> _rowItems;
  ListBuilder<InfoBoxItem> get rowItems =>
      _$this._rowItems ??= new ListBuilder<InfoBoxItem>();
  set rowItems(ListBuilder<InfoBoxItem> rowItems) =>
      _$this._rowItems = rowItems;

  InfoBoxRowBuilder();

  InfoBoxRowBuilder get _$this {
    if (_$v != null) {
      _rowName = _$v.rowName;
      _isCuratedRow = _$v.isCuratedRow;
      _rowItems = _$v.rowItems?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InfoBoxRow other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$InfoBoxRow;
  }

  @override
  void update(void Function(InfoBoxRowBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$InfoBoxRow build() {
    _$InfoBoxRow _$result;
    try {
      _$result = _$v ??
          new _$InfoBoxRow._(
              rowName: rowName,
              isCuratedRow: isCuratedRow,
              rowItems: rowItems.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'rowItems';
        rowItems.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'InfoBoxRow', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
