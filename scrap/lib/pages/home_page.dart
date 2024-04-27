import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_textfield.dart';
import 'package:scrap/components/my_wallpost.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // text controller
  final textController = TextEditingController();

  // logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // post message
  void postMessage() {
    // only post if there is something in the text field
    if (textController.text.isNotEmpty) {
      // store in firebase
      FirebaseFirestore.instance.collection("user posts").add({
        'user email': currentUser.email,
        'message': textController.text,
        'time stamp': Timestamp.now(),
      });
    }

    // clear text box after posting
    setState(() {
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "SCRAP",
          style: TextStyle(fontFamily: 'Karla', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // sign out button
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // the wall
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user posts")
                  .orderBy("time stamp", descending: false)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        // get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['message'],
                          user: post['user email'],
                        );
                      }));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: " + snapshot.error.toString()),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            )),

            // post message
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: MyTextField(
                    controller: textController,
                    hintText: "Let's hear it...",
                    obscureText: false,
                  )),

                  // post button
                  IconButton(
                      onPressed: postMessage,
                      icon: Icon(Icons.arrow_circle_up,
                          size: 35,
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ],
              ),
            ),

            // logged in as
            Text(
              "What's on your mind " + currentUser.email! + "?",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
