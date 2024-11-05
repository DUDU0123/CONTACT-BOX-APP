import 'package:contact_box/core/components/common_icon_button.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/native_action_methods.dart';
import 'package:flutter/material.dart';

class CommonTileContainer extends StatelessWidget {
  const CommonTileContainer({
    super.key, required this.infoName, required this.isTrailingNeeded, required this.title, this.subtitle, required this.leadingIcon,
  });
  final String infoName;
  final bool isTrailingNeeded;
  final String title;
  final String? subtitle;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 53, 53, 53),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           TextWidgetCommon(
            text: infoName,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading:  Icon(
              leadingIcon,
              color: kWhite,
            ),
            title:  TextWidgetCommon(
              text: title,
              maxLines: infoName=="Address"?null: 1,
              overflow:infoName=="Address"? TextOverflow.ellipsis:null,
            ),
            subtitle:subtitle!=null?  TextWidgetCommon(
              text: subtitle!,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ):zeroMeasuredWidget,
            trailing: isTrailingNeeded? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                commonIconButton(
                  icon: Icons.call,
                  onPressed: () {
                    NativeActionMethods.makePhoneCall(
                        "+916238534634");
                  },
                ),
                commonIconButton(
                  icon: Icons.message,
                  onPressed: () async {
                    const String phoneNumber =
                        '+916238534634'; // Replace with the contact's phone number
                    await NativeActionMethods.openMessageApp(
                        phoneNumber: phoneNumber);
                  },
                ),
              ],
            ):zeroMeasuredWidget,
          )
        ],
      ),
    );
  }
}