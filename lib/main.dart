import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_login/utils/global_bloc_delegate.dart';
import 'package:bloc_login/repositories/auth_repository.dart';
import 'package:bloc_login/blocs/auth.dart';

import 'package:bloc_login/screens/home_screen.dart';
import 'package:bloc_login/screens/login_screen.dart';
import 'package:bloc_login/screens/splash_screen.dart';
import 'package:bloc_login/widgets/loading_indicator.dart';

void main() {
  BlocSupervisor.delegate = GlobalBlocDelegate();
  final authRepository = AuthRepository();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(authRepository: authRepository)..add(AppStarted());
      },
      child: App(authRepository: authRepository),
    ),
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;

  App({@required authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUninitialized) {
            return SplashScreen();
          }
          if (state is AuthAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthUnauthenticated) {
            return LoginScreen(authRepository: _authRepository);
          }
          if (state is AuthLoading) {
            return LoadingIndicator();
          }
          return null;
        },
      ),
    );
  }
}
