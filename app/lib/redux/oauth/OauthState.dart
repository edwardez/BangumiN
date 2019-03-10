import 'package:built_value/built_value.dart';

part 'OauthState.g.dart';

abstract class OauthState implements Built<OauthState, OauthStateBuilder> {
  @nullable
  bool get showLoginErrorSnackBar;

  @nullable
  String get oauthFailureMessage;

  @nullable
  String get error;

  OauthState._();

  factory OauthState([updates(OauthStateBuilder b)]) =>
      _$OauthState((b) => b..update(updates));
}
