import 'package:equatable/equatable.dart';

import '../../../domain/entities/auth/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String email;
  final String name;
  final String lastName;
  final String dni;
  final DateTime birthDate;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.lastName,
    required this.dni,
    required this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      lastName: json['lastName'],
      dni: json['dni'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'lastName': lastName,
      'dni': dni,
      'birthDate': birthDate.toIso8601String(),
    };
  }

// En user_model.dart
UserEntity toEntity() {
  return UserEntity(
    id: id,
    username: username,
    email: email,
    name: name,
    lastName: lastName,
    dni: dni,
    birthDate: birthDate,
  );
}

  @override
  List<Object?> get props => [id, username, email, name, lastName, dni, birthDate];
}