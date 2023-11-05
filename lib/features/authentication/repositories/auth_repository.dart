import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:econexus/features/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/utils.dart';
import '../../home/screens/home_screen.dart';

class AuthRepository {
  //sign up here

  void signUp(BuildContext context, UserModel model) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: model.email, password: model.password)
        .then((value) async {
      //add user to firestore
      uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      UserModel newModel = UserModel(
          name: model.name,
          email: model.email,
          password: model.password,
          uid: uid,
          profileImage: '',
          relaxationTime: model.relaxationTime,
          city: model.city,
          eventsJoined: model.relaxationTime);

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(newModel.toMap());

      moveScreen(context, HomeScreen(), true, isPushReplacement: true);
    });
  }

  void logIn(BuildContext context, String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      moveScreen(context, HomeScreen(), true, isPushReplacement: true);
    }).onError((error, stackTrace) {
      showSnackbar(context, error.toString());
    });
  }
}
