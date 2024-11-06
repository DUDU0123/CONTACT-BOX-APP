import 'package:flutter/material.dart';

Widget appLogo() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          "assets/contact_box.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }