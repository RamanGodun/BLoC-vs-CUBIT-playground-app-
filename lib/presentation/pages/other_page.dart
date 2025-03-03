import 'package:bloc_by_korean/presentation/text_widget.dart';
import 'package:flutter/material.dart';

/// 📄 [OtherPage] displays a simple screen with a centered "Other" text.
/// This page can be used as a placeholder or a separate feature screen.
class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Other page', TextType.titleMedium),
        centerTitle: true,
      ),
      body: const Center(
        child: TextWidget('Other', TextType.headline),
      ),
    );
  }
}
