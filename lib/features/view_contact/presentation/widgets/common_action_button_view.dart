import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:flutter/material.dart';

class CommonActionButtonInView extends StatelessWidget {
  const CommonActionButtonInView({
    super.key,
    required this.icon,
    required this.actionName,
    this.onTap,
  });
  final IconData icon;
  final String actionName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kDarkishBlack,
            ),
            child: Icon(
              icon,
              color: kWhite,
            ),
          ),
          kHeight5,
          TextWidgetCommon(
            text: actionName,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
