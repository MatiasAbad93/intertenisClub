import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _vibrationEnabled = true;
  String _selectedLanguage = 'Español';
  double _fontSize = 16.0;

  final List<String> _languages = ['Español', 'English', 'Português'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferencias de la Aplicación',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD4AF37),
            ),
          ),
          const Divider(color: Color(0xFFD4AF37)),
          const SizedBox(height: 16),
          _buildSettingSwitch(
            title: 'Modo Oscuro',
            value: _darkModeEnabled,
            icon: Icons.dark_mode,
            onChanged: (value) {
              setState(() => _darkModeEnabled = value);
              // Aquí iría la lógica para cambiar el tema
            },
          ),
          _buildSettingSwitch(
            title: 'Notificaciones',
            value: _notificationsEnabled,
            icon: Icons.notifications,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
          _buildSettingSwitch(
            title: 'Vibración',
            value: _vibrationEnabled,
            icon: Icons.vibration,
            onChanged: (value) => setState(() => _vibrationEnabled = value),
          ),
          const SizedBox(height: 24),
          const Text(
            'Personalización',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD4AF37),
            ),
          ),
          const Divider(color: Color(0xFFD4AF37)),
          const SizedBox(height: 16),
          _buildLanguageSelector(),
          const SizedBox(height: 16),
          _buildFontSizeSlider(),
          const SizedBox(height: 24),
          const Text(
            'Cuenta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD4AF37),
            ),
          ),
          const Divider(color: Color(0xFFD4AF37)),
          const SizedBox(height: 16),
          _buildSettingButton(
            title: 'Cambiar Contraseña',
            icon: Icons.lock,
            onTap: () {
              // Navegar a pantalla de cambio de contraseña
            },
          ),
          _buildSettingButton(
            title: 'Privacidad y Seguridad',
            icon: Icons.security,
            onTap: () {
              // Navegar a pantalla de privacidad
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Lógica para guardar todas las configuraciones
                _saveSettings();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Configuraciones guardadas'),
                    backgroundColor: Color(0xFFD4AF37),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'GUARDAR CAMBIOS',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                // Lógica para cerrar sesión
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required bool value,
    required IconData icon,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFD4AF37),
        inactiveTrackColor: Colors.grey[700],
      ),
    );
  }

  Widget _buildSettingButton({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFFD4AF37)),
      onTap: onTap,
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      leading: const Icon(Icons.language, color: Color(0xFFD4AF37)),
      title: const Text('Idioma', style: TextStyle(color: Colors.white)),
      subtitle: Text(_selectedLanguage, style: const TextStyle(color: Colors.grey)),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        dropdownColor: Colors.grey[900],
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFD4AF37)),
        items: _languages.map((String language) {
          return DropdownMenuItem<String>(
            value: language,
            child: Text(
              language,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() => _selectedLanguage = newValue);
          }
        },
      ),
    );
  }

  Widget _buildFontSizeSlider() {
    return ListTile(
      leading: const Icon(Icons.text_fields, color: Color(0xFFD4AF37)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tamaño de texto', style: TextStyle(color: Colors.white)),
          Row(
            children: [
              const Icon(Icons.text_format, size: 16, color: Colors.grey),
              Expanded(
                child: Slider(
                  value: _fontSize,
                  min: 14.0,
                  max: 22.0,
                  divisions: 4,
                  label: _fontSize.round().toString(),
                  activeColor: const Color(0xFFD4AF37),
                  inactiveColor: Colors.grey[700],
                  onChanged: (value) => setState(() => _fontSize = value),
                ),
              ),
              const Icon(Icons.text_format, size: 22, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    // Aquí iría la lógica para guardar las configuraciones en el backend
    print('Configuraciones guardadas:');
    print('Modo oscuro: $_darkModeEnabled');
    print('Notificaciones: $_notificationsEnabled');
    print('Vibración: $_vibrationEnabled');
    print('Idioma: $_selectedLanguage');
    print('Tamaño de texto: $_fontSize');
  }
}