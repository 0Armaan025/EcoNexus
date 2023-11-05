import 'package:econexus/common/drawer_file.dart';
import 'package:econexus/constants/constants.dart';
import 'package:econexus/features/eco_mind/breathing_activity.dart';
import 'package:flutter/material.dart';

class EcoMindScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Eco Mind'),
      ),
      body: Activities(),
    );
  }
}

class Activities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Set the number of columns in the grid
      padding: EdgeInsets.all(16.0),
      children: [
        ActivityCard(
          title: 'Breathing Exercise',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BreathingActivity()),
            );
          },
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ActivityCard({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 3,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
