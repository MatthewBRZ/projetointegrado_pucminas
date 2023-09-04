import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final double fontSize;

  DefaultText({
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final customTextStyle = TextStyle(
      fontSize: fontSize,
      fontFamily: 'baskervville',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Text(text, style: customTextStyle);
  }
}
