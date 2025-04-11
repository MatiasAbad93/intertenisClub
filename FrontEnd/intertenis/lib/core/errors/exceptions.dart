// lib/core/errors/exceptions.dart
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => 'AppException: $message';
}

class ServerException extends AppException {
  const ServerException({
    String message = 'Error de servidor',
    int? statusCode,
  }) : super(message, statusCode: statusCode);
}

class ConnectionException extends AppException {
  const ConnectionException({
    String message = 'Error de conexión',
  }) : super(message);
}

class CacheException extends AppException {
  const CacheException({
    String message = 'Error de caché',
  }) : super(message);
}

class InvalidDataException extends AppException {
  const InvalidDataException({
    String message = 'Datos inválidos',
  }) : super(message);
}

class AuthenticationException extends AppException {
  const AuthenticationException({
    String message = 'Error de autenticación',
  }) : super(message);
}

class PermissionException extends AppException {
  const PermissionException({
    String message = 'Permisos insuficientes',
  }) : super(message);
}

class TimeoutException extends AppException {
  const TimeoutException({
    String message = 'Tiempo de espera agotado',
  }) : super(message);
}

class FormatException extends AppException {
  const FormatException({
    String message = 'Error de formato',
  }) : super(message);
}