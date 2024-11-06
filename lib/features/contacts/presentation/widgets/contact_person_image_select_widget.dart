import 'package:contact_box/core/components/common_contact_avatar.dart';
// import 'package:contact_box/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ContactPersonImageSelectWidget extends StatelessWidget {
  const ContactPersonImageSelectWidget({
    super.key, this.centerAlphabet,
  });
  final String? centerAlphabet;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Center(
         child:  CommonContactAvatar(
          fontSize: 75,
            avatarContainerSize: 150,
            centerAlphabet: centerAlphabet,
          ),
       ),
        // Positioned(
        //   top: 0,right: 0,left: 0,bottom: 0,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.camera_alt,
        //       color: kWhite,size: 38,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
