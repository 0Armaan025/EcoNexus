import 'package:econexus/constants/constants.dart';
import 'package:econexus/features/authentication/screens/log_in/sign_in_screen.dart';
import 'package:econexus/features/authentication/screens/sign_up/sign_up_screen.dart';
import 'package:econexus/features/carbon_footprint_updater/carbon_footprint_updater_screen.dart';
import 'package:econexus/features/ecochampions/screens/ecochampion_leaderboard_screen.dart';
import 'package:econexus/features/home/screens/home_screen.dart';
import 'package:econexus/features/profile/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../features/onboarding_screen/onboarding_screen.dart';
import 'features/eco_mind/screens/eco_mind.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runApp(const MyApp());
}

// test 1 -> passed

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen()
          : OnBoardingScreen(),
    );
  }
}
