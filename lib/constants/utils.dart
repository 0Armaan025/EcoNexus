import 'package:flutter/material.dart';

void moveScreen(BuildContext context, Widget screenName, bool pushReplacement, {required bool isPushReplacement}) {
  if (pushReplacement) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}