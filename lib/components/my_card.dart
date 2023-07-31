import 'package:flutter/material.dart';

Widget myCard(String url, Widget text) {
  return Container(
    height: 200,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      elevation: 2.0,
      color: Colors.blueGrey,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
                opacity: 0.6, image: NetworkImage(url), fit: BoxFit.cover),
          ),
          child: Center(
            child: text,
          )),
    ),
  );
}
