import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Column(
        children: [
          // header
          // home list profile
          // profile list tile
          // logout button
        ],
      ),
    );
  }
}
