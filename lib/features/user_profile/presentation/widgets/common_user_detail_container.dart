import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:flutter/material.dart';

Widget commonUserDetailContainer({required String value, required String label,}) {
  return Container(
    width: screenWidth(context: navigatorKey.currentContext!),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kWhite),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidgetCommon(
          textColor: kDarkishBlack,
          text: label,maxLines: 1,overflow: TextOverflow.ellipsis,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        TextWidgetCommon(
          text: value,maxLines: 2,overflow: TextOverflow.ellipsis,
          fontSize: 17,
          fontWeight: FontWeight.normal,
        ),
      ],
    ),
  );
}