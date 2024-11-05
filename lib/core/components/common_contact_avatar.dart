import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CommonContactAvatar extends StatelessWidget {
  const CommonContactAvatar({
    super.key, required this.avatarContainerSize,
  });
  final double avatarContainerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: avatarContainerSize,
      width: avatarContainerSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kAmber,
      ),
      child: const Center(
        child: TextWidgetCommon(
          text: "A",
          fontSize: 20,
          textColor: kGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
