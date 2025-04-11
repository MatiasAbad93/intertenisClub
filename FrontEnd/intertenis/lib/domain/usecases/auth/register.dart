import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/auth/user_entity.dart';
import '../../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.register(
      username: params.username,
      password: params.password,
      email: params.email,
      name: params.name,
      lastName: params.lastName,
      dni: params.dni,
      birthDate: params.birthDate,
    );
  }
}

class RegisterParams {
  final String username;
  final String password;
  final String email;
  final String name;
  final String lastName;
  final String dni;
  final DateTime birthDate;

  RegisterParams({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.lastName,
    required this.dni,
    required this.birthDate,
  });
}