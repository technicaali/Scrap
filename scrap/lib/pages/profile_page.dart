import 'package:cloud_firestore/cloud_firestore.dart';
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

  // all users
  final usersCollection = FirebaseFirestore.instance.collection('users');

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(
                  'edit $field',
                  style: TextStyle(
                    fontFamily: 'Inconsolata',
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                content: TextField(
                  autofocus: true,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: 'Karla'),
                  decoration: InputDecoration(
                      hintText: "new $field",
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'Inconsolata')),
                  onChanged: (value) {
                    newValue = value;
                  },
                ),
                actions: [
                  // cancel button
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'cancel',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: 'Karla'),
                      )),

                  // save button
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(newValue),
                      child: Text(
                        'save',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: 'Karla'),
                      ))
                ]));

    // update in firestore
    if (newValue.trim().length > 0) {
      // only update if there is something in the textfield
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

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
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            // get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
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
                    text: userData['username'],
                    sectionName: 'username',
                    onPressed: () => editField('username'),
                  ),

                  // bio
                  MyTextBox(
                    text: userData['bio'],
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
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }

            return Center(
              child: const CircularProgressIndicator(),
            );
          }),
    );
  }
}
