import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:munin/blocs/authentication/authentication.dart';
import 'package:munin/providers/authentication_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// bloc for handling authentication
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationState currentState, AuthenticationEvent event) async* {
    if (event is AppStarted) {
      if (AuthenticationCredentials.data == null) {
        AuthenticationCredentials.data = await SharedPreferences.getInstance();
        AuthenticationCredentials.data.setBool('isLoggedIn', false);
      }

      if (AuthenticationCredentials.data.getBool('isLoggedIn') ?? false) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      AuthenticationCredentials.data.setBool('isLoggedIn', true);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      AuthenticationCredentials.data.setBool('isLoggedIn', false);
      yield AuthenticationUnauthenticated();
    }
  }
}
