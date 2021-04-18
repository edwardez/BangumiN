import 'package:munin/config/application.dart';

void main() => EnvironmentExample();

class EnvironmentExample extends Application {
  final environmentType = EnvironmentType.Development;
  final bangumiOauthClientIdentifier = '1';
  final bangumiOauthClientSecret = '2';
  final bangumiRedirectUrl = '3';
}
