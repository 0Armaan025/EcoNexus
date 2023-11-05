import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/ecoprojects/screens/project_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/Theme.dart';

class MissionCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  MissionCard({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Increased height
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 100,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  height: 50,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: AppTheme.headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppTheme.paragraphColor,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    moveScreen(
                        context,
                        ProjectDetailsScreen(
                            projectName: 'name',
                            image: imageUrl,
                            location: 'location',
                            description: description,
                            goal: 'planting trees',
                            startDate: '5 nov, 2023',
                            organizer: 'Armaan'),
                        false,
                        isPushReplacement: false);
                  },
                  child: Text("Join"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
