import 'package:meta/meta.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';

class FailureAction {
  final LoadingStatus loadingStatus;

  const FailureAction({@required this.loadingStatus});

  const FailureAction.fromUnknownException()
      : this(loadingStatus: LoadingStatus.UnknownException);
}
