import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String name;
  final String lastName;
  final String dni;
  final DateTime birthDate;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.lastName,
    required this.dni,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [id, username, email, name, lastName, dni, birthDate];
}