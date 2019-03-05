import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munin/blocs/authentication/authentication.dart';
import 'package:munin/blocs/authentication/authentication_bloc.dart';
import 'package:munin/blocs/authentication/authentication_event.dart';
import 'package:munin/config/development.dart';
import 'package:munin/config/environment.dart';
import 'package:munin/styles/theme/bangumi_pink_blue.dart';
import 'package:munin/widgets/home/home_page.dart';
import 'package:munin/widgets/initial/login.dart';
import 'package:munin/widgets/initial/splash.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
//  in dev environment, create a bloc delegation to debug state transition
  BlocSupervisor().delegate = SimpleBlocDelegate();
  //  AuthenticationCredentials.data = await SharedPreferences.getInstance();
  Development();
}

class MuninApp extends StatefulWidget {
  final Env env;

  MuninApp(this.env);

  @override
  State<StatefulWidget> createState() {
    return _MuninAppState();
  }
}

class _MuninAppState extends State<MuninApp> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc();
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        theme: BangumiPinkBlue().data,
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationAuthenticated) {
              return MuninHomePage(title: 'Munin');
            }

            if (state is AuthenticationUnauthenticated) {
              return MuninLoginPage(title: 'Munin');
            }

            if (state is AuthenticationUninitialized) {
              return InitialSplashPage();
            }
          },
        ),
      ),
    );
  }
}
