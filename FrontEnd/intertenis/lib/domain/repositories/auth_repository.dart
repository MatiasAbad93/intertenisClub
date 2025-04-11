// lib/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/auth/user_entity.dart';


abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String username,
    required String password,
    required String email,
    required String name,
    required String lastName,
    required String dni,
    required DateTime birthDate,
  });

  Future<Either<Failure, void>> logout();
}