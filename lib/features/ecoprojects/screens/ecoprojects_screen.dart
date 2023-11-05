import 'package:econexus/common/mission_card.dart'; // Import the MissionCard widget
import 'package:econexus/constants/constants.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/ecoprojects/screens/add_eco_project_screen.dart';
import 'package:econexus/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/drawer_file.dart';

class EcoProjectsScreen extends StatefulWidget {
  const EcoProjectsScreen({super.key});

  @override
  State<EcoProjectsScreen> createState() => _EcoProjectsScreenState();
}

class _EcoProjectsScreenState extends State<EcoProjectsScreen> {
  // Sample mission data
  final List<MissionCard> missions = [
    MissionCard(
      title: "Mission 1",
      description: "Description of Mission 1.",
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1673279000427-c3f650c46cd5?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZWNvfGVufDB8fDB8fHww",
    ),
    MissionCard(
      title: "Mission 2",
      description: "Description of Mission 2.",
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1673279000427-c3f650c46cd5?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZWNvfGVufDB8fDB8fHww",
    ),
    // Add more mission data here
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          moveScreen(context, AddEcoProjectScreen(), false,isPushReplacement: true);
        },
        child: Icon(
          Icons.add,
          color: AppTheme.buttonTextColor,
        ),
        backgroundColor: AppTheme.buttonColor,
      ),
      appBar: AppBar(
        title: Text("$appName"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Eco Projects 🏗️",
                style: GoogleFonts.akshar(
                  fontSize: 40,
                  color: AppTheme.headingTextColor,
                ),
              ),
            ),
            Center(
              child: Text(
                "Time to make an impact 🌱",
                style: GoogleFonts.akshar(
                  fontSize: 17,
                  color: AppTheme.headingTextColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: missions.length,
              itemBuilder: (context, index) {
                return MissionCard(
                  title: missions[index].title,
                  description: missions[index].description,
                  imageUrl: missions[index].imageUrl,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
