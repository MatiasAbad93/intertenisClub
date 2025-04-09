import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Datos de ejemplo del usuario - reemplazar con datos reales
  final Map<String, dynamic> _userProfile = {
    'nombre': 'Juan Pérez',
    'email': 'juan.perez@email.com',
    'dni': '12345678',
    'fechaNacimiento': DateTime(1990, 5, 15),
    'telefono': '+5491122334455',
    'categoria': 'Avanzado',
    'fechaInscripcion': DateTime(2022, 1, 10),
    'partidosJugados': 24,
    'partidosGanados': 18,
    'ranking': 3,
  };

  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = _userProfile['telefono'];
    _categoryController.text = _userProfile['categoria'];
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    if (_isEditing && _formKey.currentState!.validate()) {
      // Guardar cambios
      setState(() {
        _userProfile['telefono'] = _phoneController.text;
        _userProfile['categoria'] = _categoryController.text;
      });
    }
    setState(() => _isEditing = !_isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD4AF37),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _userProfile['nombre'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4AF37),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _userProfile['email'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Información Personal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
            ),
            const Divider(color: Color(0xFFD4AF37)),
            const SizedBox(height: 16),
            _buildProfileItem('DNI', _userProfile['dni']),
            _buildProfileItem(
              'Fecha de Nacimiento', 
              DateFormat('dd/MM/yyyy').format(_userProfile['fechaNacimiento']),
            ),
            _isEditing
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD4AF37)),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese un teléfono válido';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _categoryController,
                          decoration: const InputDecoration(
                            labelText: 'Categoría',
                            labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD4AF37)),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese una categoría válida';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      _buildProfileItem('Teléfono', _userProfile['telefono']),
                      _buildProfileItem('Categoría', _userProfile['categoria']),
                    ],
                  ),
            const SizedBox(height: 30),
            const Text(
              'Estadísticas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37)),
              ),
            const Divider(color: Color(0xFFD4AF37)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Partidos', _userProfile['partidosJugados'].toString()),
                _buildStatCard('Victorias', _userProfile['partidosGanados'].toString()),
                _buildStatCard('Ranking', '#${_userProfile['ranking']}'),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              'Efectividad', 
              '${(_userProfile['partidosGanados'] / _userProfile['partidosJugados'] * 100).toStringAsFixed(1)}%',
              fullWidth: true,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para cerrar sesión
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Cerrar Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(color: Color(0xFFD4AF37))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, {bool fullWidth = false}) {
    return Container(
      width: fullWidth ? double.infinity : null,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD4AF37)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFD4AF37),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}