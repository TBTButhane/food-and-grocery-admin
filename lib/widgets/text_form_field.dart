// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, required this.textController, this.labelName})
      : super(key: key);
  final TextEditingController? textController;
  final String? labelName;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        label: labelName == null ? Text("Restaurant Name") : Text(labelName!),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.green, width: 1.3),
        ),
      ),
    );
  }
}
