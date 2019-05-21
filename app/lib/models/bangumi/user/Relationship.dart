import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'Relationship.g.dart';

/// Relationship between two users
/// Two users might share more than one relationship
/// i.e. A is [Relationship.Following] B, while [Relationship.FollowedBy] B
/// In this case they are mutual friends
/// This structure is inspired by twitter
/// https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/api-reference/get-friendships-lookup.html
class Relationship extends EnumClass {
  /// Two user have no relationship
  static const Relationship None = _$None;

  /// Currnet user is following target user
  static const Relationship Following = _$Following;

  /// Current user is followed by target user
  static const Relationship FollowedBy = _$FollowedBy;

  /// Calculates relationship text according
  static String relationshipText(Iterable<Relationship> relationships) {
    assert(relationships != null);

    /// If [Iterable] is not a set, convert to set first for a better performance
    if (relationships is! Set && relationships is! BuiltSet) {
      relationships = Set.from(relationships);
    }

    if (relationships.contains(Relationship.None) || relationships.isEmpty) {
      return '关注';
    }

    if (relationships.contains(Relationship.Following) &&
        relationships.contains(Relationship.FollowedBy)) {
      return '互相关注';
    }

    if (relationships.contains(Relationship.Following)) {
      return '已关注';
    }

    if (relationships.contains(Relationship.FollowedBy)) {
      return '已关注我';
    }

    assert(false, '$relationships is not a valid relationship combination');

    return '-';
  }

  const Relationship._(String name) : super(name);

  static BuiltSet<Relationship> get values => _$values;

  static Relationship valueOf(String name) => _$valueOf(name);

  static Serializer<Relationship> get serializer => _$relationshipSerializer;
}
