import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_button.dart';
import 'package:scrap/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //email and pw text controllers
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmTextController = TextEditingController();

  // register method
  void register() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordTextController.text != confirmTextController.text) {
      // pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage("passwords don't match");
      return;
    }

    // try creating the user
    try {
      // create the user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      // after creating the user, create a new document in the cloud Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set({
        'username': emailTextController.text.split('@')[0],
        'bio': 'cricket noises...'
      });

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      displayMessage(e.code);
    }
  }

  // display a dialog message
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text(
              message,
              style: TextStyle(fontFamily: 'Inconsolata'),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(Icons.lock,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary),

              const SizedBox(height: 50),

              // welcome back message
              Text(
                "Let's create an account for you.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // email text field
              MyTextField(
                hintText: "email",
                obscureText: false,
                controller: emailTextController,
              ),

              const SizedBox(height: 10),

              // pw text field
              MyTextField(
                hintText: "password",
                obscureText: true,
                controller: passwordTextController,
              ),

              const SizedBox(height: 10),

              // confirm pw text field
              MyTextField(
                hintText: "confirm password",
                obscureText: true,
                controller: confirmTextController,
              ),

              const SizedBox(height: 25),

              // login button
              MyButton(text: "register", onTap: () => register()),

              const SizedBox(height: 25),

              // sign up button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: 'Karla'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
