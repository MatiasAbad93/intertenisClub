import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      
      // Verifica los diferentes tipos de conexión
      if (connectivityResult == ConnectivityResult.none) {
        return false; // No hay conexión
      }
      
      // Hay algún tipo de conexión (móvil, wifi, ethernet, etc.)
      return true;
      
    } catch (e) {
      // En caso de error, asumimos que no hay conexión
      return false;
    }
  }
}