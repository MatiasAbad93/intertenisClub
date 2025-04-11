part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final bool rememberMe;

  const LoginEvent({
    required this.username,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object> get props => [username, password, rememberMe];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String email;
  final String name;
  final String lastName;
  final String dni;
  final DateTime birthDate;

  const RegisterEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.lastName,
    required this.dni,
    required this.birthDate,
  });

  @override
  List<Object> get props => [username, password, email, name, lastName, dni, birthDate];
}

class LogoutEvent extends AuthEvent {}