import 'package:flutter/material.dart';
import 'package:scrap/components/my_listTile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;

  MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(
                  child: Icon(Icons.auto_awesome_outlined,
                      size: 100,
                      color: Theme.of(context).colorScheme.background)),

              // home list profile
              MyListTile(
                icon: Icons.home_outlined,
                text: 'h o m e',
                onTap: () => Navigator.pop(context),
              ),

              // profile list tile
              MyListTile(
                icon: Icons.child_care,
                text: 'p r o f i l e',
                onTap: onProfileTap,
              ),
            ],
          ),

          // logout button
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: MyListTile(
              icon: Icons.logout_outlined,
              text: 'l o g o u t',
              onTap: onLogoutTap,
            ),
          )
        ],
      ),
    );
  }
}
