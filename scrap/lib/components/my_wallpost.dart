import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          // profile pic
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.person,
                color: Theme.of(context).colorScheme.tertiary),
          ),

          const SizedBox(width: 20),

          // message and user
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
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
