import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/auth/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String username,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(const ConnectionFailure());
    }

    try {
      final user = await remoteDataSource.login(
        username: username,
        password: password,
      );
      return Right(user.toEntity());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      return Left(mapExceptionToFailure(
        ServerException(message: e.toString())
      ));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String username,
    required String password,
    required String email,
    required String name,
    required String lastName,
    required String dni,
    required DateTime birthDate,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(const ConnectionFailure());
    }

    try {
      final user = await remoteDataSource.register(
        username: username,
        password: password,
        email: email,
        name: name,
        lastName: lastName,
        dni: dni,
        birthDate: birthDate,
      );
      return Right(user.toEntity());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      return Left(mapExceptionToFailure(
        ServerException(message: e.toString())
      ));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    throw UnimplementedError();
  }
}