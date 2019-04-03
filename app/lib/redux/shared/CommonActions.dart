import 'package:meta/meta.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class FailureAction {
  final LoadingStatus loadingStatus;

  FailureAction({@required this.loadingStatus});

  FailureAction.fromUnknownException()
      : this(loadingStatus: LoadingStatus.UnknownException);
}
