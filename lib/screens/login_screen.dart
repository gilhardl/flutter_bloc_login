import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_login/repositories/auth_repository.dart';
import 'package:bloc_login/blocs/auth.dart';
import 'package:bloc_login/blocs/login.dart';

import 'package:bloc_login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  LoginScreen({@required authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            authRepository: _authRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
