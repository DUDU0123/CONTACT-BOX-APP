import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget commonIconButton({
  required IconData icon,
  required void Function()? onPressed,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon,
      color: kWhite,
    ),
  );
}
