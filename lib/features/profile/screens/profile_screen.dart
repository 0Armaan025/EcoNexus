import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/drawer_file.dart';
import '../../../theme/Theme.dart'; // Import your app's theme if available

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<FlSpot> relaxationTimeData = [
    FlSpot(0, 30), // Day 1
  ];

  Map<String, double> ecoAwarenessEventsData = {
    'Joined': 5,
    'Remaining': 15,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      'https://makeuc.io/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Flogo.dd962578.png&w=828&q=75'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Armaan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('armaan33000@gmail.com'),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(20),
              height: 250, // Adjust the height as needed
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Relaxation time",
                        style: GoogleFonts.roboto(
                          color:
                              AppTheme.paragraphColor, // Use your app's theme
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(
                      axisNameWidget: Text(
                        "time in mins",
                        style: GoogleFonts.roboto(
                          color:
                              AppTheme.paragraphColor, // Use your app's theme
                        ),
                      ),
                    ),
                    show: true,
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  minY: 0,
                  maxY: 60, // Adjust the Y-axis max value as needed
                  barGroups: relaxationTimeData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value.y;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          borderRadius: BorderRadius.circular(0),
                          width: 170,
                          toY: value,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      value: ecoAwarenessEventsData['Joined'],
                      title:
                          '${ecoAwarenessEventsData['Joined']?.toStringAsFixed(0) ?? 0}',
                      color: Colors.blue,
                      titleStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                      showTitle: true,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  centerSpaceColor: Colors.white,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            // Add your badge display widget here
            // Example:
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Badges',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add your badges here
                  // Example:
                  Row(
                    children: <Widget>[
                      Badge(
                        label: 'Badge 1',
                        color: Colors.green,
                      ),
                      Badge(
                        label: 'Badge 2',
                        color: Colors.blue,
                      ),
                      Badge(
                        label: 'Badge 3',
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Badge widget to display a badge
class Badge extends StatelessWidget {
  final String label;
  final Color color;

  Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
