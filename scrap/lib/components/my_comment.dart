import 'package:flutter/material.dart';

class MyComment extends StatelessWidget {
  final String text;
  final String user;
  final String time;

  const MyComment({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontFamily: 'Inconsolata',
                fontWeight: FontWeight.bold),
          ),

          // user, timestamp
          Row(
            children: [
              Text(
                user,
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
                time,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
