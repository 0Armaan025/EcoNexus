import 'package:econexus/constants/constants.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/Theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.bgColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.buttonColor,
            ),
            child: Column(
              children: [
                Text(
                  '$appName',
                  style: TextStyle(
                    color: AppTheme.buttonTextColor,
                    fontSize: 34,
                  ),
                ),
                Text(
                  "Armaan",
                  style: GoogleFonts.poppins(
                    color: AppTheme.buttonTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.eco),
            title: Text('Eco Projects'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.leaderboard),
            title: Text('Eco Champions'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat Time'),
            onTap: () {
              moveScreen(context, ChatScreen(), false,
                  isPushReplacement: false);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text('Add Carbon Footprint details'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Navigate to help screen
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to about screen
            },
          ),
        ],
      ),
    );
  }
}
