import 'package:flutter/material.dart';

Widget appLogo() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          scale: 1,
          "assets/contact_box.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }