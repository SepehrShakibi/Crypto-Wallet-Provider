import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
}) {
  var snackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      content: Text(
        text,
        style: const TextStyle(fontFamily: 'RobotoR'),
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
