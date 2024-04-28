import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_drawer.dart';
import 'package:scrap/components/my_textfield.dart';
import 'package:scrap/components/my_wallpost.dart';
import 'package:scrap/pages/profile_page.dart';

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

  // go to profile page
  void toProfilePage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ));
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
        'likes': [],
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
          "s c r a p",
          style: TextStyle(
            fontFamily: 'Karla',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(
        onProfileTap: toProfilePage,
        onLogoutTap: logout,
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
                            postID: post.id,
                            likes: List<String>.from(post['likes'] ?? []));
                      }));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                return const Center(
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
              "What's on your mind ${currentUser.email!}?",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
