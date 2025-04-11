import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;
  final String baseUrl;
  final bool ignoreSSLErrors;

  ApiClient({
    http.Client? client,
    this.ignoreSSLErrors = kDebugMode,
  }) : 
    _client = client ?? http.Client(),
    baseUrl = _getBaseUrl() {
    // Configuración SSL solo para desarrollo
    if (ignoreSSLErrors) {
      _configureSSL();
    }
  }

  static String _getBaseUrl() {
    if (kIsWeb) {
      return 'https://localhost:7216';
    } else {
      return 'https://10.0.2.2:7216';
    }
  }

void _configureSSL() {
  // Solo para Android/iOS, no aplica en web
  if (!kIsWeb) {
    HttpClient client = HttpClient();
    client.badCertificateCallback = 
        (X509Certificate cert, String host, int port) => true;
  }
}

  Future<http.Response> _sendRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      debugPrint('API Request: $method $uri');
      debugPrint('Request Body: ${body != null ? jsonEncode(body) : null}');

      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response;
      
      switch (method.toUpperCase()) {
        case 'POST':
          response = await _client.post(
            uri,
            headers: {...defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'GET':
          response = await _client.get(
            uri,
            headers: {...defaultHeaders, ...?headers},
          );
          break;
        case 'PUT':
          response = await _client.put(
            uri,
            headers: {...defaultHeaders, ...?headers},
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await _client.delete(
            uri,
            headers: {...defaultHeaders, ...?headers},
          );
          break;
        default:
          throw ArgumentError('Método HTTP no soportado');
      }

      if (response == null) {
        throw Exception('La respuesta del servidor es nula');
      }

      debugPrint('API Response (${response.statusCode}): ${response.body}');

      return response;
    } on SocketException {
      throw const SocketException('Error de conexión con el servidor');
    } on HttpException {
      throw const HttpException('Error en la solicitud HTTP');
    } on FormatException {
      throw const FormatException('Error en el formato de la respuesta');
    } catch (e) {
      debugPrint('Error en ApiClient: $e');
      throw Exception('Error en la comunicación con el servidor: ${e.toString()}');
    }
  }

  // Métodos específicos
  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return _sendRequest('POST', endpoint, body: body, headers: headers);
  }

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _sendRequest('GET', endpoint, headers: headers);
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return _sendRequest('PUT', endpoint, body: body, headers: headers);
  }

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    return _sendRequest('DELETE', endpoint, headers: headers);
  }

   // Importante: cerrar el cliente cuando ya no se necesite
  void close() {
    _client.close();
  }
}
