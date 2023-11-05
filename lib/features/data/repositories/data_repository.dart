import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/authentication/models/eco_projects.dart';
import 'package:econexus/features/data/models/ecoproject.dart';
import 'package:econexus/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DataRepository {
  // function to store data
  Future<void> addEcoProject(
      BuildContext context, EcoProjectModel model) async {
    EcoProjectModel newModel = EcoProjectModel(
        name: model.name,
        bannerImage: '',
        location: model.location,
        description: model.description,
        goal: model.goal,
        startDate: model.startDate,
        uploaderUid: model.uploaderUid);

    FirebaseFirestore.instance
        .collection('ecoProjects')
        .doc(model.name)
        .set(newModel.toMap())
        .then((value) {
      moveScreen(context, HomeScreen(), false, isPushReplacement: false);
    });
  }
}
