class User {
  final String id;
  final String nombre;
  final String apellido;
  final DateTime fechaNacimiento;
  final String dni;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.dni,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Exactamente como viene en el JSON
      nombre: json['nombre'],
      apellido: json['apellido'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']), // Conversión a DateTime
      dni: json['dni'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'dni': dni,
    };
  }
}