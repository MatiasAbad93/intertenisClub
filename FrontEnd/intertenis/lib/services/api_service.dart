import 'dart:convert';
import 'dart:io'; // Importación necesaria para HttpClient
import '../models/user.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  // Configuración dinámica según plataforma
  static String get _baseUrl {
    if (kIsWeb) {
      return 'https://localhost:7216'; // Para web
    } else {
      return 'https://10.0.2.2:7216'; // Para Android/iOS
    }
  }

  // Configuración especial del cliente HTTP
  static Future<HttpClient> _getHttpClient() async {
    final HttpClient client = HttpClient();
    
    if (kDebugMode) {
      // Ignorar certificados SSL solo en desarrollo
      client.badCertificateCallback = 
          (X509Certificate cert, String host, int port) => true;
    }
    
    return client;
  }

  static Future<List<User>> getUsers() async {
    try {
      final HttpClient client = await _getHttpClient();
      final HttpClientRequest request = await client.getUrl(
        Uri.parse('$_baseUrl/api/Users')
      );
      request.headers.add('Accept', 'application/json');
      
      final HttpClientResponse response = await request.close();
      final String responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(responseBody);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Error ${response.statusCode}: $responseBody');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  static Future<User> createUser(User user) async {
    try {
      final HttpClient client = await _getHttpClient();
      final HttpClientRequest request = await client.postUrl(
        Uri.parse('$_baseUrl/api/Users')
      );
      request.headers.add('Content-Type', 'application/json');
      request.headers.add('Accept', 'application/json');
      request.write(jsonEncode(user.toJson()));
      
      final HttpClientResponse response = await request.close();
      final String responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 201) {
        return User.fromJson(jsonDecode(responseBody));
      } else {
        throw Exception('Error al crear usuario: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}