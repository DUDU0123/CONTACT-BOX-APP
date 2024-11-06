import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CommonContactAvatar extends StatelessWidget {
  const CommonContactAvatar({
    super.key, required this.avatarContainerSize, this.centerAlphabet, this.fontSize,
  });
  final double avatarContainerSize;
  final String? centerAlphabet;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: avatarContainerSize,
      width: avatarContainerSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kDarkishBlack,
      ),
      child:  Center(
        child: TextWidgetCommon(
          text: centerAlphabet??"U",
          fontSize: fontSize?? fontSize,
          textColor: kGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
