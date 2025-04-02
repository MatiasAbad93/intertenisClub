import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  static const String _baseUrl = 'https://10.0.2.2:7216'; // Para Android
  // static const String _baseUrl = 'https://localhost:7216'; // Para web

  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/Users'), // Exactamente como está en tu endpoint
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}