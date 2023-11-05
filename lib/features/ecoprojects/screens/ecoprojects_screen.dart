import 'package:econexus/common/mission_card.dart'; // Import the MissionCard widget
import 'package:econexus/constants/constants.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/ecoprojects/screens/add_eco_project_screen.dart';
import 'package:econexus/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:google_fonts/google_fonts.dart';

import '../../../common/drawer_file.dart';

class EcoProjectsScreen extends StatefulWidget {
  const EcoProjectsScreen({super.key});

  @override
  State<EcoProjectsScreen> createState() => _EcoProjectsScreenState();
}

class _EcoProjectsScreenState extends State<EcoProjectsScreen> {
  // Initialize Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          moveScreen(context, AddEcoProjectScreen(), false,
              isPushReplacement: true);
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
      body: StreamBuilder<QuerySnapshot>(
        // Stream the 'ecoProjects' collection
        stream: _firestore.collection('ecoProjects').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('No data available'); // Handle no data case
          }

          // Create a list of MissionCards from the data in 'ecoProjects'
          final List<MissionCard> missions = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>; // Cast to Map
            if (data != null) {
              // Add null check here
              return MissionCard(
                title: data['title'] ?? '',
                description: data['description'] ?? '',
                imageUrl: data['imageUrl'] ?? '',
              );
            }
            return MissionCard(
              description: '',
              imageUrl: '',
              title: '',
            ); // Handle the case where data is null
          }).toList();

          return SingleChildScrollView(
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
                    return missions[index];
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
