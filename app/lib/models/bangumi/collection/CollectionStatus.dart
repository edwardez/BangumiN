import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:quiver/strings.dart';

part 'CollectionStatus.g.dart';

/// All possible collection status values on Bangumi
/// enum names are a little bit strange and confusing but this is in sync with bangumi API
@BuiltValueEnum(wireName: 'type')
class CollectionStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: 'wish')
  static const CollectionStatus Wish = _$Wish;

  /// Collected
  @BuiltValueEnumConst(wireName: 'collect')
  static const CollectionStatus Collect = _$Collect;

  /// In progress
  @BuiltValueEnumConst(wireName: 'do')
  static const CollectionStatus Do = _$Do;

  @BuiltValueEnumConst(wireName: 'on_hold')
  static const CollectionStatus OnHold = _$OnHold;

  @BuiltValueEnumConst(wireName: 'dropped')
  static const CollectionStatus Dropped = _$Dropped;

  /// Following types don't exist in bangumi json response

  /// User has not touched this subject
  @BuiltValueEnumConst(wireName: 'untouched')
  static const CollectionStatus Untouched = _$Untouched;

  /// User may or may not have touched this subject, we are not aware of the actual
  /// status
  @BuiltValueEnumConst(wireName: 'unknown')
  static const CollectionStatus Unknown = _$Unknown;

  @memoized
  String get wiredName {
    switch (this) {
      case CollectionStatus.Wish:
        return 'wish';
      case CollectionStatus.Collect:
        return 'collect';
      case CollectionStatus.Do:
        return 'do';
      case CollectionStatus.OnHold:
        return 'on_hold';
      case CollectionStatus.Dropped:
        return 'dropped';
      case CollectionStatus.Untouched:
      case CollectionStatus.Unknown:
        return '';
      default:
        assert(false, '$this is not supported');
        return '';
    }
  }

  /// If subject is under one of these statuses, user is officially allowed to
  /// modify child episode status.
  /// Otherwise, munin may still try to submit the episode update request, but
  /// the consequence is unknown.
  static Set<CollectionStatus> allowedCanModifyEpisodeStatues = {
    CollectionStatus.Collect,
    CollectionStatus.Do
  };

  /// Checks whether user can safely modify episode status.
  ///
  /// By saying 'safely', here it means whether bangumi officially supports modifying
  /// status of an episode under current [CollectionStatus].
  bool get canSafelyModifyEpisodeStatus =>
      allowedCanModifyEpisodeStatues.contains(this);

  static String chineseNameWithSubjectType(CollectionStatus status,
      SubjectType subjectType, {
        String fallbackChineseName,
      }) {
    switch (status) {
      case CollectionStatus.Wish:
        return '想${subjectType.activityVerbChineseNameByType}';
      case CollectionStatus.Collect:
        return '${subjectType.activityVerbChineseNameByType}过';
      case CollectionStatus.Do:
        return '在${subjectType.activityVerbChineseNameByType}';
      case CollectionStatus.OnHold:
        return '搁置';
      case CollectionStatus.Dropped:
        return '抛弃';
      case CollectionStatus.Untouched:
      case CollectionStatus.Unknown:
      default:
        if (fallbackChineseName != null) {
          return fallbackChineseName;
        }
        assert(false, '$status with $subjectType is not supported');
        return '';
    }
  }

  /// Guess collection status by searching through a given String
  /// `fallbackCollectionStatus` can be used to specify which status to return
  /// if this method cannot decide correct `CollectionStatus`
  static CollectionStatus guessCollectionStatusByChineseName(String chineseName,
      {fallbackCollectionStatus = CollectionStatus.Unknown}) {
    if (isEmpty(chineseName)) {
      return fallbackCollectionStatus;
    }

    if (chineseName.contains('想')) {
      return CollectionStatus.Wish;
    }

    if (chineseName.contains('在')) {
      return CollectionStatus.Do;
    }

    if (chineseName.contains('过')) {
      return CollectionStatus.Collect;
    }

    if (chineseName.contains('抛弃')) {
      return CollectionStatus.Dropped;
    }

    if (chineseName.contains('搁置')) {
      return CollectionStatus.OnHold;
    }

    return fallbackCollectionStatus;
  }

  static bool isInvalid(CollectionStatus status) {
    return status == null ||
        status == CollectionStatus.Untouched ||
        status == CollectionStatus.Unknown;
  }

  const CollectionStatus._(String name) : super(name);

  static BuiltSet<CollectionStatus> get values => _$values;

  static CollectionStatus valueOf(String name) => _$valueOf(name);

  static Serializer<CollectionStatus> get serializer =>
      _$collectionStatusSerializer;
}
