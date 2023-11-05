import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econexus/common/custom_card_widget.dart';
import 'package:econexus/common/custom_features_row.dart';
import 'package:econexus/constants/constants.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/ecochampions/screens/ecochampion_leaderboard_screen.dart';
import 'package:econexus/features/ecoprojects/screens/ecoprojects_screen.dart';
import 'package:econexus/theme/Theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/drawer_file.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Current index for the carousel slider

  // List of items for the carousel slider
  final List<String> carouselItems = [
    'https://plus.unsplash.com/premium_photo-1666345061648-d5f55842a515?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZWNvJTIwcHJvamVjdHxlbnwwfHwwfHx8MA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1665203593041-e2727fc9f137?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZWNvJTIwbWFsbHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1527871369852-eb58cb2b54e2?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hhbXBib258ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1679260883717-ce385e9d4a1a?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZWNvfGVufDB8fDB8fHww',
  ];

  double plotData = 0;
  double eventsJoined = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
      var data = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        setState(() {
          plotData = double.parse(snapshot.get('relaxationTime'));
          eventsJoined = double.parse(snapshot.get('eventsJoined'));
        });
      });
    }
  }

  // Sample data for user relaxation time in minutes
  List<FlSpot> relaxationTimeData = [];

  Map<String, double> ecoAwarenessEventsData = {
    'Joined': 0, // Initialize with 0, you will update it later
    'Remaining': 15,
  };

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    relaxationTimeData.add(FlSpot(0, plotData));
    ecoAwarenessEventsData['Joined'] = eventsJoined;

    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        title: Text("$appName"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 18, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Good evening, Armaan 👋🏻",
                      style: GoogleFonts.poppins(
                        color: AppTheme.headingTextColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "5th November, 2023",
                      style: GoogleFonts.roboto(color: AppTheme.paragraphColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              items: carouselItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage('${item}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselItems.map((item) {
                int index = carouselItems.indexOf(item);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              "User Relaxation Time (in minutes)",
              style: GoogleFonts.poppins(
                color: AppTheme.headingTextColor,
                fontSize: 11,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 250, // Adjust the height as needed
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Relaxation time",
                        style:
                            GoogleFonts.roboto(color: AppTheme.paragraphColor),
                      ),
                    ),
                    rightTitles: AxisTitles(
                      axisNameWidget: Text(
                        "time in mins",
                        style:
                            GoogleFonts.roboto(color: AppTheme.paragraphColor),
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
                  maxY: 200, // Adjust the Y-axis max value as needed
                  barGroups: relaxationTimeData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value.y;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          borderRadius: BorderRadius.circular(0),
                          width: 30,
                          toY: value,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Eco Awareness Events",
              style: GoogleFonts.poppins(
                color: AppTheme.headingTextColor,
                fontSize: 18,
              ),
            ),
            Container(
              height: 350,
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
            const SizedBox(height: 25),
            CustomCardWidget(
              onTap: () {
                moveScreen(context, EcoProjectsScreen(), false,
                    isPushReplacement: false);
              },
              bgColor: Colors.blue,
              textColor: Colors.white,
              text: "Eco-Projects",
              imageUrl:
                  'https://plus.unsplash.com/premium_photo-1666345061648-d5f55842a515?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZWNvJTIwcHJvamVjdHxlbnwwfHwwfHx8MA%3D%3D',
            ),
            CustomCardWidget(
              onTap: () {
                moveScreen(context, EcoChampionLeaderboardScreen(), false,
                    isPushReplacement: false);
              },
              bgColor: Colors.purple,
              textColor: Colors.white,
              text: "Eco-Champions",
              imageUrl:
                  'https://media.istockphoto.com/id/1139813965/photo/holding-gold-trophy.webp?b=1&s=170667a&w=0&k=20&c=aboDhcxBwIuhQNzkI7Wc_-u3NcvopLUb8OuNVu-LhUI=',
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Made with 💖 by Armaan and SG!",
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
