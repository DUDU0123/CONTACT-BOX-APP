import 'package:contact_box/core/components/common_contact_avatar.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ContactPersonImageSelectWidget extends StatelessWidget {
  const ContactPersonImageSelectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      const Center(
         child:  CommonContactAvatar(
            avatarContainerSize: 150,
          ),
       ),
        Positioned(
          top: 0,right: 0,left: 0,bottom: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt,
              color: kWhite,size: 38,
            ),
          ),
        ),
      ],
    );
  }
}
