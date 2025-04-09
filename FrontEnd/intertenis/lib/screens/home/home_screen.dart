import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('INTER TENIS CLUB', 
          style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18)),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD4AF37)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            tooltip: 'Mi perfil',
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('MENÚ PRINCIPAL', 
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 20)),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.calendar_today,
              text: 'Fixture de Partidos',
              route: '/fixture',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.leaderboard,
              text: 'Tabla de Posiciones',
              route: '/standings',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.how_to_vote,
              text: 'Votar Disponibilidad',
              route: '/availability',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              text: 'Configuración',
              route: '/settings',
            ),
            const Divider(color: Color(0xFFD4AF37)),
            _buildDrawerItem(
              context,
              icon: Icons.exit_to_app,
              text: 'Cerrar Sesión',
              onTap: () {
                // Lógica para cerrar sesión
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Sección de bienvenida
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[900],
            child: const Center(
              child: Text(
                'PRÓXIMOS PARTIDOS',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Accesos rápidos
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              childAspectRatio: 1.2,
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Fixture',
                  route: '/fixture',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.leaderboard,
                  title: 'Posiciones',
                  route: '/standings',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.how_to_vote,
                  title: 'Disponibilidad',
                  route: '/availability',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.person,
                  title: 'Mi Perfil',
                  route: '/profile',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Fixture',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Posiciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/fixture');
              break;
            case 2:
              Navigator.pushNamed(context, '/standings');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, 
      {required IconData icon, required String text, String? route, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: onTap ?? () => Navigator.pushNamed(context, route!),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFD4AF37)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}