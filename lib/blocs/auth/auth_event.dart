import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  LoggedIn({@required this.token});

  final String token;

  @override
  List<Object> get props => [token];

  @override
  toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthEvent {}
