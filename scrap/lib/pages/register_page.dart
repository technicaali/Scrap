import 'package:flutter/material.dart';
import 'package:scrap/components/my_button.dart';
import 'package:scrap/components/my_textfield.dart';
import 'package:scrap/services/auth/auth.dart';

class RegisterPage extends StatelessWidget {
  //email and pw text controllers
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmTextController = TextEditingController();

  final Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  // register method
  void register(BuildContext context) async {
    // get auth service
    final _auth = Auth();

    //show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    // if passwords match, then create user
    if (passwordTextController.text == confirmTextController.text) {
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
      try {
        _auth.signUpWithEmailPassword(
            emailTextController.text, passwordTextController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }

    // passwords dont match -> tell user to fix
    else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match!"),
              ));
    }
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
              MyButton(text: "register", onTap: () => register(context)),

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
                    onTap: onTap,
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
