import 'package:flutter_bloc/flutter_bloc.dart'; // Cambiar import de bloc a flutter_bloc
import 'package:equatable/equatable.dart';

import '../../domain/entities/auth/user_entity.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/register.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;

  AuthBloc({
    required this.login,
    required this.register,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await login(LoginParams(
      username: event.username,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.message ?? 'Error desconocido')), // Añadir manejo de null
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await register(RegisterParams(
      username: event.username,
      password: event.password,
      email: event.email,
      name: event.name,
      lastName: event.lastName,
      dni: event.dni,
      birthDate: event.birthDate,
    ));

    result.fold(
      (failure) => emit(AuthError('Error desconocido')),
      (user) => emit(Authenticated(user)),
    );
  }

  void _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
  }
}