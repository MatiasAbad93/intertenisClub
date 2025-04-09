import 'dart:io';
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

import 'screens/auth/registrer_details_screen.dart';
import 'screens/auth/registrer_screen.dart';
import 'screens/home/availability_screen.dart';
import 'screens/home/fixture_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/profile_screen.dart';
import 'screens/home/settings_screen.dart';
import 'screens/home/standings_screen.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const TennisClubApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = 
          (X509Certificate cert, String host, int port) => true;
  }
}

class TennisClubApp extends StatelessWidget {
  const TennisClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intertenis Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFD4AF37), // Amarillo oscuro
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(
            color: Color(0xFFD4AF37), // Amarillo oscuro
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          labelStyle: const TextStyle(color: Color(0xFFD4AF37)),
        ),
        cardTheme: CardTheme(
          color: Colors.grey[900],
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/register-details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return RegisterDetailsScreen(
            username: args['username']!,
            password: args['password']!,
          );
        },
        '/home': (context) => const HomeScreen(),
        '/fixture': (context) => const FixtureScreen(),
        '/standings': (context) => const StandingsScreen(),
        '/availability': (context) => const AvailabilityScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        // Manejo para rutas con parámetros
        if (settings.name == '/register-details') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => RegisterDetailsScreen(
              username: args['username']!,
              password: args['password']!,
            ),
          );
        }
        return null;
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}