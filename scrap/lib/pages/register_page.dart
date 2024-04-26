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
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back message
              Text(
                "Let's create an account for you.",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              // email text field
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailTextController,
              ),

              const SizedBox(height: 10),

              // pw text field
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordTextController,
              ),

              const SizedBox(height: 10),

              // confirm pw text field
              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmTextController,
              ),

              const SizedBox(height: 25),

              // login button
              MyButton(text: "Register", onTap: () => register(context)),

              const SizedBox(height: 25),

              // sign up button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
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
