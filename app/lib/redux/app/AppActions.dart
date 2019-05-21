import 'package:munin/redux/app/BasicAppState.dart';

class PersistAppStateAction {
  /// Whether only [BasicAppState] should be persisted
  final bool basicAppStateOnly;

  PersistAppStateAction({this.basicAppStateOnly = false});
}
