import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_textBox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // edit field
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "p r o f i l e",
          style: TextStyle(
            fontFamily: 'Karla',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          // profile picture
          Icon(
            Icons.auto_awesome,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 75,
          ),

          const SizedBox(
            height: 10,
          ),

          // user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // user details
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("My Details",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.bold)),
          ),

          // username
          MyTextBox(
            text: 'aalimarier',
            sectionName: 'username',
            onPressed: () => editField('username'),
          ),

          // bio
          MyTextBox(
            text: 'empty bio',
            sectionName: 'bio',
            onPressed: () => editField('bio'),
          ),

          const SizedBox(
            height: 50,
          ),

          // user posts
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("My Posts",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
