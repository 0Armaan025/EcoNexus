import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/drawer_file.dart';
import '../../constants/utils.dart';
import '../home/screens/home_screen.dart';

class CarbonFootprintUpdaterScreen extends StatefulWidget {
  @override
  _CarbonFootprintUpdaterScreenState createState() =>
      _CarbonFootprintUpdaterScreenState();
}

class _CarbonFootprintUpdaterScreenState
    extends State<CarbonFootprintUpdaterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _distanceController = TextEditingController();
  String _selectedTransportationMode = 'Car';
  double _carbonFootprint = 0.0;
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  final List<String> transportationModes = [
    'Car',
    'Bus',
    'Cycle',
    'Motorbike',
    'Electric Car',
    'Subway',
    'Tram',
    'Walking',
    'Scooter',
    'Train',
  ];

  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Carbon Footprint'),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _distanceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter distance traveled';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Distance Traveled (km)',
                      icon: Icon(Icons.directions_car),
                    ),
                    enabled: !isUpdating,
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedTransportationMode,
                    onChanged: (value) {
                      setState(() {
                        _selectedTransportationMode = value!;
                      });
                    },
                    items: transportationModes.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Row(
                          children: [
                            Icon(getModeIcon(mode)),
                            SizedBox(width: 8.0),
                            Text(mode),
                          ],
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Transportation Mode',
                      icon: Icon(getModeIcon(_selectedTransportationMode)),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (!isUpdating && _formKey.currentState!.validate()) {
                        setState(() {
                          isUpdating = true;
                        });

                        _updateCarbonFootprint().then((_) {
                          confettiController.play();
                          setState(() {
                            isUpdating = false;
                          });
                        });
                      }
                    },
                    child: Text('Calculate Carbon Footprint'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Carbon Footprint: $_carbonFootprint kg CO2',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Add functionality to update the carbon footprint here
                      },
                      child: Text(
                        'Update Carbon Footprint',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 30,
            gravity: 0.1,
            maxBlastForce: 20,
            minBlastForce: 10,
            emissionFrequency: 0.02,
          ),
        ],
      ),
    );
  }

  IconData getModeIcon(String mode) {
    switch (mode) {
      case 'Car':
        return Icons.directions_car;
      case 'Bus':
        return Icons.directions_bus;
      case 'Cycle':
        return Icons.directions_bike;
      case 'Motorbike':
        return Icons.motorcycle;
      case 'Electric Car':
        return Icons.electrical_services;
      case 'Subway':
        return Icons.subway;
      case 'Tram':
        return Icons.tram;
      case 'Walking':
        return Icons.directions_walk;
      case 'Scooter':
        return Icons.electric_scooter;
      case 'Train':
        return Icons.train;
      default:
        return Icons.directions_car;
    }
  }

  double calculateCarbonFootprint(double distance, String mode) {
    double carbonFootprint = 0.0;
    switch (mode) {
      case 'Car':
        carbonFootprint = distance * 0.2;
        break;
      case 'Bus':
        carbonFootprint = distance * 0.03;
        break;
      case 'Cycle':
        carbonFootprint = distance * 0.0;
        break;
      case 'Motorbike':
        carbonFootprint = distance * 0.1;
        break;
      case 'Electric Car':
        carbonFootprint = distance * 0.15;
        break;
      case 'Subway':
        carbonFootprint = distance * 0.02;
        break;
      case 'Tram':
        carbonFootprint = distance * 0.025;
        break;
      case 'Walking':
        carbonFootprint = distance * 0.0;
        break;
      case 'Scooter':
        carbonFootprint = distance * 0.07;
        break;
      case 'Train':
        carbonFootprint = distance * 0.05;
        break;
    }
    return carbonFootprint;
  }

  Future<void> _updateCarbonFootprint() async {
    // Simulate an update process (you can replace this with your logic)

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final String? currentUid = _auth.currentUser?.uid ?? '';

    if (currentUid != null) {
      // Fetch the user's document
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '');

      // Get the current carbonEmissions field
      int currentEmissions = 0; // Initial value if the field is not found
      final userDocSnapshot = await userDoc.get();
      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data();
        if (userData != null && userData['carbonEmissions'] != null) {
          currentEmissions = int.tryParse(userData['carbonEmissions']) ?? 0;
        }
      }

      // Calculate the new carbon footprint
      final newCarbonFootprint = currentEmissions +
          calculateCarbonFootprint(
            double.parse(_distanceController.text),
            _selectedTransportationMode,
          );

      // Update the carbonEmissions field with the new value as a string
      await userDoc.update({'carbonEmissions': newCarbonFootprint.toString()});

      setState(() {
        _carbonFootprint = newCarbonFootprint.toDouble();
      });
    }
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
