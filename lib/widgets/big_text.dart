import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  const BigText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.fontColor = Colors.black,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      style: TextStyle(
          fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
    );
  }
}
