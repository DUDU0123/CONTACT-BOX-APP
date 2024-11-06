import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget commonUserDetailContainer({required String value}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kWhite),
    ),
    child: TextWidgetCommon(
      text: value,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  );
}