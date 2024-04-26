import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(
          "SCRAP",
          style: TextStyle(fontFamily: 'Karla', fontWeight: FontWeight.bold),
        ),
        actions: [
          // sign out button
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
