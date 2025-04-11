// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';
import 'package:intertenis/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => 'Failure: $message';
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure([super.message = 'Error de conexión']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Error de caché']);
}

class InvalidDataFailure extends Failure {
  const InvalidDataFailure([super.message = 'Datos inválidos']);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message = 'Error de autenticación']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permisos insuficientes']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Tiempo de espera agotado']);
}

class FormatFailure extends Failure {
  const FormatFailure([super.message = 'Error de formato']);
}

Failure mapExceptionToFailure(Exception exception) {
  if (exception is AppException) {
    if (exception is ServerException) {
      return ServerFailure(
        exception.message,
        statusCode: exception.statusCode,
      );
    } else if (exception is ConnectionException) {
      return ConnectionFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is InvalidDataException) {
      return InvalidDataFailure(exception.message);
    } else if (exception is AuthenticationException) {
      return AuthenticationFailure(exception.message);
    } else if (exception is PermissionException) {
      return PermissionFailure(exception.message);
    } else if (exception is TimeoutException) {
      return TimeoutFailure(exception.message);
    } else if (exception is FormatException) {
      return FormatFailure(exception.message);
    }
  }
  return ServerFailure(exception.toString());
}