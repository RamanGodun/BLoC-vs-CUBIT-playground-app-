import 'package:flutter/material.dart';

class DialogService {
  static void showAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text(text),
            ),
          ),
        );
      },
    );
  }
}
