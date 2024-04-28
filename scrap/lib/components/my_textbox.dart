import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(
                sectionName,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'Karla',
                    fontWeight: FontWeight.bold),
              ),

              // edit button
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.edit_rounded,
                      color: Theme.of(context).colorScheme.primary))
            ],
          ),

          // text
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontFamily: 'Inconsolata',
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
