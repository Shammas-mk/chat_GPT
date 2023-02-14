import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  TextWidget({
    super.key,
    required this.label,
    this.color,
    this.fontSize = 18,
    this.fontWeight,
  });

  String label;
  double fontSize;
  Color? color;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
