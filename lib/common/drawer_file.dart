import 'package:econexus/constants/constants.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/carbon_footprint_updater/carbon_footprint_updater_screen.dart';
import 'package:econexus/features/chat/screens/chat_screen.dart';
import 'package:econexus/features/eco_mind/screens/eco_mind.dart';
import 'package:econexus/features/ecochampions/screens/ecochampion_leaderboard_screen.dart';
import 'package:econexus/features/ecoprojects/screens/ecoprojects_screen.dart';
import 'package:econexus/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/profile/screens/profile_screen.dart';
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
            title: Text(
              'Home',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              moveScreen(context, HomeScreen(), true, isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.eco),
            title: Text(
              'Eco Projects',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              moveScreen(context, EcoProjectsScreen(), true,
                  isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.leaderboard),
            title: Text(
              'Eco Champions',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              moveScreen(context, EcoChampionLeaderboardScreen(), true,
                  isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text(
              'Chat Time',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              moveScreen(context, ChatScreen(), true, isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              moveScreen(context, ProfileScreen(), true,
                  isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text(
              'Add Carbon Footprint details',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              // Navigate to settings screen
              moveScreen(context, CarbonFootprintUpdaterScreen(), true,
                  isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.piano_sharp),
            title: Text(
              'Breathing Exericse ( Relaxation )',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {
              // Navigate to settings screen
              moveScreen(context, EcoMindScreen(), true,
                  isPushReplacement: true);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: GoogleFonts.poppins(color: Colors.blue),
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text(
              'Help',
              style: GoogleFonts.poppins(color: Colors.blue[200]),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.info,
            ),
            title: Text(
              'About',
              style: GoogleFonts.poppins(color: Colors.blue[200]),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
