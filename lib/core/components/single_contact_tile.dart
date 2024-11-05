import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/components/common_contact_avatar.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/utils/native_action_methods.dart';
import 'package:flutter/material.dart';

class SingleContactTile extends StatelessWidget {
  const SingleContactTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        navigatorKey.currentState?.pushNamed(AppRoutesName.contactViewPage);
      },
      leading: const CommonContactAvatar(avatarContainerSize: 50,),
      title: const TextWidgetCommon(
        text: "User name",
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      trailing: IconButton(
        onPressed: () async {
         await NativeActionMethods.makePhoneCall('');
        },
        icon: const Icon(
          Icons.call,
          color: kWhite,
        ),
      ),
    );
  }
}
