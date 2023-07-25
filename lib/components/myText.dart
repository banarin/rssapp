import 'package:flutter/material.dart';

Widget myText(String text,TextAlign align, double size,Color color) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold
    ),
  );
}
