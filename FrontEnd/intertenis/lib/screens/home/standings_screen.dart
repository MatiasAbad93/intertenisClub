import 'package:flutter/material.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  final List<Category> _categories = [
    Category(
      name: 'Singles Masculino',
      players: [
        Player(name: 'Juan Pérez', points: 120, matches: 15, wins: 12),
        Player(name: 'Carlos Gómez', points: 110, matches: 14, wins: 10),
        Player(name: 'Luis Martínez', points: 95, matches: 13, wins: 9),
        Player(name: 'Diego Fernández', points: 85, matches: 12, wins: 7),
        Player(name: 'Miguel Sánchez', points: 75, matches: 11, wins: 6),
      ],
    ),
    Category(
      name: 'Singles Femenino',
      players: [
        Player(name: 'María Rodríguez', points: 115, matches: 14, wins: 11),
        Player(name: 'Ana López', points: 105, matches: 13, wins: 9),
        Player(name: 'Sofía Castro', points: 90, matches: 12, wins: 8),
        Player(name: 'Lucía Díaz', points: 80, matches: 11, wins: 7),
        Player(name: 'Elena Ruiz', points: 70, matches: 10, wins: 5),
      ],
    ),
    Category(
      name: 'Dobles Mixto',
      players: [
        Player(name: 'Pérez/Rodríguez', points: 130, matches: 16, wins: 14),
        Player(name: 'Gómez/López', points: 115, matches: 15, wins: 12),
        Player(name: 'Martínez/Castro', points: 100, matches: 14, wins: 10),
        Player(name: 'Fernández/Díaz', points: 85, matches: 13, wins: 8),
        Player(name: 'Sánchez/Ruiz', points: 75, matches: 12, wins: 6),
      ],
    ),
  ];

  int _selectedCategoryIndex = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabla de Posiciones'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(_categories[index].name),
                      selected: _selectedCategoryIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      selectedColor: const Color(0xFFD4AF37),
                      backgroundColor: Colors.grey[900],
                      labelStyle: TextStyle(
                        color: _selectedCategoryIndex == index 
                            ? Colors.black 
                            : Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          _isLoading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DataTable(
                        columnSpacing: 24,
                        dataRowMinHeight: 40,
                        dataRowMaxHeight: 60,
                        headingTextStyle: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        dataTextStyle: const TextStyle(color: Colors.white),
                        columns: const [
                          DataColumn(label: Text('Pos')),
                          DataColumn(label: Text('Jugador')),
                          DataColumn(label: Text('Pts'), numeric: true),
                          DataColumn(label: Text('PJ'), numeric: true),
                          DataColumn(label: Text('PG'), numeric: true),
                          DataColumn(label: Text('%'), numeric: true),
                        ],
                        rows: _categories[_selectedCategoryIndex]
                            .players
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final player = entry.value;
                          final winPercentage = (player.wins / player.matches * 100).toStringAsFixed(1);
                          
                          return DataRow(
                            cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(player.name)),
                              DataCell(Text(player.points.toString())),
                              DataCell(Text(player.matches.toString())),
                              DataCell(Text(player.wins.toString())),
                              DataCell(Text('$winPercentage%')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final List<Player> players;

  Category({required this.name, required this.players});
}

class Player {
  final String name;
  final int points;
  final int matches;
  final int wins;

  Player({
    required this.name,
    required this.points,
    required this.matches,
    required this.wins,
  });
}