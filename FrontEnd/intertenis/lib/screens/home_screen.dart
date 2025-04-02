// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../models/user.dart';

// class HomeScreen extends StatelessWidget {
//   Future<List<User>> fetchUsers() async {
//     final data = await ApiService.getUsers();
//     return data.map((json) => User.fromJson(json)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Usuarios del Club')),
//       body: FutureBuilder<List<User>>(
//         future: fetchUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//           if (!snapshot.hasData) return CircularProgressIndicator();
          
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final user = snapshot.data![index];
//               return ListTile(
//                 title: Text(user.name),
//                 subtitle: Text(user.email),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }