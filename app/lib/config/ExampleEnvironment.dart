import 'package:munin/config/application.dart';

void main() => ExampleEnvironment();

class ExampleEnvironment extends Application {
  final environmentType = EnvironmentType.Development;
  final bangumiOauthClientIdentifier = '1';
  final bangumiOauthClientSecret = '2';
  final bangumiRedirectUrl = '3';
}
