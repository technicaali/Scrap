import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_button.dart';
import 'package:scrap/components/my_textfield.dart';
import 'package:scrap/services/auth/auth.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // login method
  void login(BuildContext context) async {
    // auth service
    final authService = Auth();

    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    // try login
    try {
      await authService.signInWithEmailAndPassword(
        emailTextController.text,
        passwordTextController.text,
      );

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  // display dialog message
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 50),

                // welcome back message
                Text(
                  "Welcome back, we missed you.",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontFamily: 'Karla',
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                // email text field
                MyTextField(
                    hintText: 'email',
                    obscureText: false,
                    controller: emailTextController),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                    hintText: 'password',
                    obscureText: true,
                    controller: passwordTextController),

                const SizedBox(height: 10),

                // sign in button
                MyButton(text: 'sign in', onTap: () => login(context)),

                const SizedBox(height: 10),

                // go to register page button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'Karla',
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: 'Karla',
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
