// lib/data/datasources/auth_remote_data_source.dart
import 'dart:convert';

import '../../core/errors/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/auth/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });

  Future<UserModel> register({
    required String username,
    required String password,
    required String email,
    required String name,
    required String lastName,
    required String dni,
    required DateTime birthDate,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/auth/login', // Endpoint actualizado
        body: {
          'username': username,
          'password': password,
        },
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(responseBody);
      } else if (response.statusCode == 401) {
        throw const AuthenticationException(message: 'Credenciales inválidas');
      } else if (response.statusCode == 400) {
        throw const InvalidDataException(message: 'Datos de entrada inválidos');
      } else {
        throw ServerException(
          message: responseBody['message'] ?? 'Error en el servidor',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Error desconocido: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register({
    required String username,
    required String password,
    required String email,
    required String name,
    required String lastName,
    required String dni,
    required DateTime birthDate,
  }) async {
    try {
      final response = await apiClient.post(
      '/api/Users/register', // Endpoint corregido
        body: {
          'username': username,
          'password': password,
          'email': email,
          'name': name,
          'lastName': lastName,
          'dni': dni,
          'birthDate': birthDate.toIso8601String(),
        },
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return UserModel.fromJson(responseBody);
      } else if (response.statusCode == 400) {
        throw InvalidDataException(
          message: responseBody['message'] ?? 'Datos de registro inválidos',
        );
      } else if (response.statusCode == 409) {
        throw const InvalidDataException(message: 'El usuario ya existe');
      } else {
        throw ServerException(
          message: responseBody['message'] ?? 'Error en el servidor',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Error desconocido: ${e.toString()}');
    }
  }
}