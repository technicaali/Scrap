import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/services/auth/login_or_register.dart';
import 'package:scrap/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if user is logged in
            if (snapshot.hasData) {
              return HomePage();
            }

            // if user has not logged in
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
