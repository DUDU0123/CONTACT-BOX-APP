import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

List<Widget> favoriteActionButtons() {
  return [
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.add,
        size: 25,
      ),
    ),
    TextButton(
      onPressed: () {},
      child: const TextWidgetCommon(
        text: "Select",
        fontSize: 16,
        textColor: kWhite,
      ),
    ),
  ];
}
