import 'package:bloc_by_korean/presentation/text_widget.dart';
import 'package:flutter/material.dart';

/// A service class to manage and display dialogs within the application.
abstract class DialogService {
  /// Displays a customizable alert dialog with the provided [text].
  /// The dialog is centered and takes 40% of the screen height, using [MediaQuery].

  static void showAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: Center(
            child: TextWidget(text, TextType.button),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Center(child: TextWidget('OK', TextType.titleMedium)),
          ),
        ],
      ),
    );
  }
}
