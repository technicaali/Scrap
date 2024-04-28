import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading:
            Icon(icon, color: Theme.of(context).colorScheme.tertiary, size: 30),
        title: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontFamily: 'Karla',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        onTap: onTap,
      ),
    );
  }
}
