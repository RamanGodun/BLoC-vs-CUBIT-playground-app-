import 'package:flutter/material.dart';
import '../../core/utils/helpers.dart';
import '../constants.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final TextType? textType;
  final Color? color;
  final TextAlign? alignment;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextWidget(
    this.text,
    this.textType, {
    super.key,
    this.color,
    this.alignment,
    this.fontWeight,
    this.fontSize,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Helpers.getTextTheme(context);

    // Reusable text builder that applies custom styles
    Text buildText(TextStyle? baseStyle) {
      return Text(
        text ?? 'No name',
        textAlign: alignment ?? TextAlign.center,
        style: baseStyle?.copyWith(
          color: color ?? baseStyle.color,
          fontWeight: fontWeight ?? baseStyle.fontWeight,
          fontSize: fontSize ?? baseStyle.fontSize,
        ),
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    // Select the appropriate text style based on the text type
    switch (textType) {
      case TextType.headline:
        return buildText(textTheme.headlineMedium);
      case TextType.smallHeadline:
        return buildText(textTheme.headlineSmall);
      case TextType.titleSmall:
        return buildText(textTheme.titleSmall);
      case TextType.titleMedium:
        return buildText(textTheme.titleMedium);
      case TextType.body:
        return buildText(textTheme.bodyMedium);
      case TextType.button:
        return buildText(
          textTheme.titleMedium?.copyWith(
            color: Helpers.getColorScheme(context).secondary,
          ),
        );
      case TextType.error:
        return buildText(
          textTheme.bodyLarge?.copyWith(color: UIConstants.errorColor),
        );
      default:
        return buildText(textTheme.bodyMedium);
    }
  }
}

// Enum to define different types of text widgets
enum TextType {
  headline,
  smallHeadline,
  titleSmall,
  titleMedium,
  body,
  button,
  error,
}
