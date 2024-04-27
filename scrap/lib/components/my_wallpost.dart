import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_likebutton.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postID;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postID,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Access the document in Firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('user posts').doc(widget.postID);

    if (isLiked) {
      // if the post is now liked, add the user's email to the 'likes' field
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      // if the post is now unliked, remove the user's email from the 'likes' field
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          // like button
          Column(
            children: [
              LikeButton(isLiked: isLiked, onTap: toggleLike),

              const SizedBox(height: 5),

              // like count
              Text(
                widget.likes.length.toString(),
                style: TextStyle(
                  fontFamily: 'Karla',
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              )
            ],
          ),

          const SizedBox(width: 20),

          // message and user
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontFamily: 'Inconsolata',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
