// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class TileCard extends StatelessWidget {
  final Widget? widget;
  final double? hight;
  final double? width;
  final Color? color;

  const TileCard({
    Key? key,
    required this.widget,
    this.hight,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2)),
      child: Center(
        child: widget,
      ),
    );
  }
}
