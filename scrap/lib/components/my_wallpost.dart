import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrap/components/my_comment.dart';
import 'package:scrap/components/my_commentbutton.dart';
import 'package:scrap/components/my_likebutton.dart';
import 'package:scrap/services/helper.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postID;
  final String time;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postID,
    required this.likes,
    required this.time,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // comment text controller
  final commentTextController = TextEditingController();

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

  // add a comment
  void addComment(String commentText) {
    // write the comment to firestore the comments collection for this post
    FirebaseFirestore.instance
        .collection('user posts')
        .doc(widget.postID)
        .collection('comments')
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  // show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(
                'add a comment...',
                style: TextStyle(
                  fontFamily: 'Karla',
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              content: TextField(
                  controller: commentTextController,
                  decoration: InputDecoration(
                      hintText: 'write a comment...',
                      hintStyle: TextStyle(
                          fontFamily: 'Inconsolata',
                          color: Theme.of(context).colorScheme.primary))),
              actions: [
                // cancel button
                TextButton(
                    onPressed: () {
                      // pop box
                      Navigator.pop(context);

                      // clear controller
                      commentTextController.clear();
                    },
                    child: Text(
                      'cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: 'Karla'),
                    )),

                // save button
                TextButton(
                    onPressed: () {
                      // add comment
                      addComment(commentTextController.text);

                      // pop box
                      Navigator.pop(context);

                      // clear controller
                      commentTextController.clear();
                    },
                    child: Text(
                      'post',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: 'Karla'),
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // message and user
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // post
                  Text(
                    widget.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontFamily: 'Inconsolata',
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // user
                  Row(
                    children: [
                      Text(
                        widget.user,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: 'Karla',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' · ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: 'Karla',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: 'Karla',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(width: 20),

              // buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LIKE
                  Column(
                    children: [
                      // like button
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

                  const SizedBox(
                    width: 10,
                  ),

                  // COMMENT
                  Column(
                    children: [
                      // comment button
                      CommentButton(onTap: showCommentDialog),

                      const SizedBox(height: 5),

                      // comment count
                      Text(
                        '0',
                        style: TextStyle(
                          fontFamily: 'Karla',
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          // comments under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user posts')
                .doc(widget.postID)
                .collection('comments')
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              // show loading circle if no data yet
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true, // nested lists
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // get the comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  // return the comment
                  return MyComment(
                      text: commentData['CommentText'],
                      user: commentData['CommentedBy'],
                      time: formatDate(commentData["CommentTime"]));
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
