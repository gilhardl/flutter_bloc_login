import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_login/blocs/auth/auth_event.dart';
import 'package:bloc_login/blocs/auth/auth_state.dart';
import 'package:bloc_login/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required authRepository})
      : assert(authRepository != null),
        this._authRepository = authRepository;

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await _authRepository.hasToken();

      if (hasToken) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await _authRepository.persistToken(event.token);
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await _authRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
