// lib/core/constants/app_constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  // Nombre de la aplicación
  static const String appName = 'Intertenis Club';

  // Colores de la aplicación
  static const int primaryColorValue = 0xFFD4AF37;
  static const Color primaryColor = Color(primaryColorValue);
  static const Color scaffoldBackgroundColor = Colors.black;
  static const Color textColor = Colors.white;
  static const Color errorColor = Colors.redAccent;
  static const Color successColor = Colors.greenAccent;

  // Tiempos y duraciones
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration apiTimeout = Duration(seconds: 30);

  // Textos comunes
  static const String loginTitle = 'Iniciar Sesión';
  static const String registerTitle = 'Registro';
  static const String homeTitle = 'Inicio';
  static const String welcomeMessage = 'Bienvenido a $appName';
  static const String rememberMe = 'Recordarme';
  static const String forgotPassword = '¿Olvidó su contraseña?';
  static const String noAccount = '¿No tienes una cuenta? ';
  static const String signUp = 'Regístrate';
  static const String continueText = 'Continuar';

  // Validaciones
  static const String usernameRequired = 'Nombre de usuario requerido';
  static const String emailRequired = 'Email requerido';
  static const String invalidEmail = 'Ingrese un email válido';
  static const String passwordRequired = 'Contraseña requerida';
  static const String passwordLength = 'Mínimo 6 caracteres';
  static const String passwordsNotMatch = 'Las contraseñas no coinciden';
  static const String nameRequired = 'Nombre requerido';
  static const String lastNameRequired = 'Apellido requerido';
  static const String dniRequired = 'DNI requerido';
  static const String birthDateRequired = 'Fecha de nacimiento requerida';

  // Tamaños y dimensiones
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double textFieldHeight = 50.0;
  static const double buttonHeight = 50.0;
  static const double appBarHeight = 56.0;

  // Assets paths
  static const String logoPath = 'assets/images/logo.png';
  static const String backgroundPath = 'assets/images/background.jpg';
}