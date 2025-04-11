// lib/injection_container.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'bloc/auth/auth_bloc.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth/login.dart';
import 'domain/usecases/auth/register.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => AuthBloc(
        login: sl(),
        register: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );

  // Core
sl.registerLazySingleton(() => Connectivity());
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));  
  // Registra el ApiClient con configuración para desarrollo
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      ignoreSSLErrors: true, // Habilitado solo en desarrollo
    ),
  );

  // Registra el cliente HTTP por separado para permitir su cierre
  sl.registerLazySingleton(() => http.Client());

  // Registra el disposer para limpieza
  sl.registerSingleton(
    Disposable(() {
      sl<http.Client>().close();
      // Agrega aquí otros recursos que necesiten limpieza
    }),
  );
}

// Clase auxiliar para manejar la liberación de recursos
class Disposable {
  final void Function() dispose;
  Disposable(this.dispose);
}