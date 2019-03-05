import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:munin/blocs/authentication/authentication.dart';
import 'package:munin/blocs/authentication/authentication_bloc.dart';
import 'package:munin/blocs/login/login.dart';

/// bloc for handling login
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationBloc,
  }) : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      authenticationBloc.dispatch(LoggedIn());
      yield LoginInitial();
    }
  }
}
