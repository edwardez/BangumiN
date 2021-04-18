import 'package:munin/config/production.dart';

void main() => ExampleProductionWithUpdateDetector();

class ExampleProductionWithUpdateDetector extends Production {
  final shouldCheckUpdate = true;
}
