import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../common/drawer_file.dart';
import '../../../constants/constants.dart';

class ProjectConfirmationScreen extends StatefulWidget {
  const ProjectConfirmationScreen({super.key});

  @override
  State<ProjectConfirmationScreen> createState() =>
      _ProjectConfirmationScreenState();
}

class _ProjectConfirmationScreenState extends State<ProjectConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
            Lottie.asset('assets/lottie/confirmation.json'),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Thanks for joining in! :D",
                style: GoogleFonts.alatsi(fontSize: 27),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Make sure to reach on time and help make an impact 🪴",
                style: GoogleFonts.alatsi(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
