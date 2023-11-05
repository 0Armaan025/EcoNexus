import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class BreathingActivity extends StatefulWidget {
  const BreathingActivity({Key? key}) : super(key: key);

  @override
  _BreathingActivityState createState() => _BreathingActivityState();
}

class _BreathingActivityState extends State<BreathingActivity> {
  int _seconds = 0;
  bool _isBreathing = false;
  late Timer _timer;
  List<String> thoughts = [
    "Relax and focus on your breath.",
    "Inhale slowly and deeply.",
    "Exhale slowly and completely.",
    "Clear your mind of any stress or worries.",
    "Feel the calmness within you.",
    "Breathe in positivity, exhale negativity.",
  ];
  String currentThought = "Breathe in and out...";
  final String backgroundImageURL =
      "https://images.unsplash.com/photo-1520962880247-cfaf541c8724?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGVhY2V8ZW58MHx8MHx8fDA%3D"; // Replace with your image URL

  int _selectedDuration = 10; // Default duration
  int _customDuration = 10; // Custom duration
  bool _customDurationInputVisible = false;

  final AudioPlayer audioPlayer = AudioPlayer();

  void playAudio() async {
    audioPlayer.play(AssetSource('lottie/music.mp3'));
  }

  void _startBreathing() {
    setState(() {
      _isBreathing = true;
      _seconds = 0;
      currentThought = thoughts[Random().nextInt(thoughts.length)];
    });

    // Play audio here
    playAudio();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });

      if (_seconds >= _selectedDuration) {
        _timer.cancel();
        setState(() {
          _isBreathing = false;
          updateRelaxationTime(_selectedDuration);
          currentThought = "Breathing exercise complete.";
        });
      }
    });
  }

  void _stopBreathing() {
    audioPlayer.stop(); // Stop audio when the breathing exercise stops
    _timer.cancel();
    setState(() {
      _isBreathing = false;
      currentThought = "Breathing exercise stopped.";
    });
  }

  void _setCustomDuration() {
    setState(() {
      _selectedDuration = _customDuration;
      _customDurationInputVisible = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Release resources when the screen is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breathing Activity'),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.network(
            backgroundImageURL,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isBreathing
                    ? Text(
                        currentThought,
                        style: TextStyle(fontSize: 20),
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                Text(
                  '$_seconds seconds',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isBreathing ? null : _startBreathing,
                  child: Text('Start Breathing Exercise'),
                ),
                ElevatedButton(
                  onPressed: _isBreathing ? _stopBreathing : null,
                  child: Text('Stop Breathing Exercise'),
                ),
                SizedBox(height: 20),
                _customDurationInputVisible
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Custom Duration (seconds):"),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              initialValue: _customDuration.toString(),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _customDuration = int.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed:
                                _customDuration > 0 ? _setCustomDuration : null,
                            child: Text("Set"),
                          ),
                        ],
                      )
                    : DropdownButton<int>(
                        value: _selectedDuration,
                        items: [10, 20, 60, 300, 400]
                            .map((value) => DropdownMenuItem<int>(
                                  value: value,
                                  key: Key(value
                                      .toString()), // Use a unique key for each item
                                  child: Text('$value seconds'),
                                ))
                            .toList()
                          ..add(DropdownMenuItem<int>(
                            value: -1,
                            key: Key(
                                "-1"), // Use a unique key for the custom duration item
                            child: Text('Custom'),
                          )),
                        onChanged: (newValue) {
                          if (newValue == -1) {
                            setState(() {
                              _customDurationInputVisible = true;
                            });
                          } else {
                            setState(() {
                              _selectedDuration = newValue!;
                              _customDurationInputVisible = false;
                            });
                          }
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BreathingActivity(),
  ));
}

// Function to update the "relaxationTime" field in Firestore
Future<void> updateRelaxationTime(int additionalMinutes) async {
  // Get the current user's ID
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId != null) {
    // Reference to the Firestore document for the current user
    final DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Get the current relaxationTime value
    final DocumentSnapshot snapshot = await userDoc.get();
    final String? relaxationTimeString = snapshot['relaxationTime'];

    if (relaxationTimeString != null) {
      // Convert the current value from string to int
      final int currentRelaxationTime = int.tryParse(relaxationTimeString) ?? 0;

      // Calculate the new relaxationTime in seconds (add minutes and convert to seconds)
      final int newRelaxationTime = currentRelaxationTime + (additionalMinutes);

      // Convert the new value back to a string
      final String newRelaxationTimeString = newRelaxationTime.toString();

      // Update the Firestore document with the new relaxationTime value
      await userDoc.update({'relaxationTime': newRelaxationTimeString});
    }
  }
}
