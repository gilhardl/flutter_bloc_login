import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_login/repositories/auth_repository.dart';

import 'package:bloc_login/blocs/auth.dart';
import 'package:bloc_login/blocs/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  LoginBloc({
    @required authRepository,
    @required authBloc,
  })  : assert(authRepository != null),
        assert(authBloc != null),
        _authRepository = authRepository,
        _authBloc = authBloc;

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await _authRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        _authBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
