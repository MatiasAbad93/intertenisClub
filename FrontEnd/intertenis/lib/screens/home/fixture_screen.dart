import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FixtureScreen extends StatefulWidget {
  const FixtureScreen({super.key});

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  final List<Match> _matches = [
    Match(
      date: DateTime.now().add(const Duration(days: 1)),
      player1: 'Juan Pérez',
      player2: 'Carlos Gómez',
      court: 'Cancha 1',
      time: '18:00 - 20:00',
      category: 'Singles',
    ),
    Match(
      date: DateTime.now().add(const Duration(days: 2)),
      player1: 'María Rodríguez',
      player2: 'Ana López',
      court: 'Cancha 2',
      time: '16:00 - 18:00',
      category: 'Singles',
    ),
    Match(
      date: DateTime.now().add(const Duration(days: 3)),
      player1: 'Pablo García / Luis Martínez',
      player2: 'Diego Fernández / Miguel Sánchez',
      court: 'Cancha 1',
      time: '20:00 - 22:00',
      category: 'Dobles',
    ),
    Match(
      date: DateTime.now().add(const Duration(days: 5)),
      player1: 'Sofía Castro',
      player2: 'Lucía Díaz',
      court: 'Cancha 3',
      time: '10:00 - 12:00',
      category: 'Singles',
    ),
  ];

  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final filteredMatches = _matches.where((match) =>
        match.date.year == _selectedDate.year &&
        match.date.month == _selectedDate.month &&
        match.date.day == _selectedDate.day).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixture de Partidos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: const Color(0xFFD4AF37),
                  onPressed: () => _changeDate(-1),
                ),
                // Text(
                //   DateFormat('EEEE dd MMMM', 'es').format(_selectedDate),
                //   style: const TextStyle(
                //     fontSize: 18,
                //     color: Color(0xFFD4AF37),
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: const Color(0xFFD4AF37),
                  onPressed: () => _changeDate(1),
                ),
              ],
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
              : filteredMatches.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'No hay partidos programados\npara este día',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: filteredMatches.length,
                        itemBuilder: (context, index) {
                          final match = filteredMatches[index];
                          return _buildMatchCard(match);
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  match.category,
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  match.time,
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Cancha: ${match.court}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        match.player1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'VS',
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    match.player2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (match.category == 'Dobles')
              const Text(
                'Partido de dobles',
                style: TextStyle(
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _changeDate(int daysToAdd) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: daysToAdd));
    });
  }
}

class Match {
  final DateTime date;
  final String player1;
  final String player2;
  final String court;
  final String time;
  final String category;

  Match({
    required this.date,
    required this.player1,
    required this.player2,
    required this.court,
    required this.time,
    required this.category,
  });
}