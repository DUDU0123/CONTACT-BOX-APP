import 'package:contact_box/core/components/common_contact_avatar.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/native_action_methods.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/appbar_icons.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/common_action_button_view.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/common_tile_container.dart';
import 'package:flutter/material.dart';

class ViewContact extends StatelessWidget {
  const ViewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidgetCommon(
          text: "User name",
        ),
        actions: appBarIconsOnContactView,
      ),
      body: SizedBox(
        width: screenWidth(context: context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonContactAvatar(avatarContainerSize: 160),
                kHeight10,
                const TextWidgetCommon(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: "User name",
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
                kHeight15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonActionButtonInView(
                      actionName: "Call",
                      icon: Icons.call,
                      onTap: () {
                        NativeActionMethods.makePhoneCall("phoneNumber");
                      },
                    ),
                    kWidth15,
                    CommonActionButtonInView(
                      actionName: "Message",
                      icon: Icons.message,
                      onTap: () {
                        NativeActionMethods.openMessageApp(phoneNumber: "");
                      },
                    ),
                  ],
                ),
                kHeight35,
                const CommonTileContainer(
                  infoName: "Contact Info",
                  isTrailingNeeded: true,
                  title: "+91 6238534634",
                  subtitle: "Mobile",
                  leadingIcon: Icons.phone_android,
                ),
                kHeight15,
                const CommonTileContainer(
                  infoName: "Address",
                  isTrailingNeeded: false,
                  title: "Knakdnknkdankds\najdajjajbajc\nhvahcabcuacasxscb",
                  subtitle: "Mobile",
                  leadingIcon: Icons.home,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
