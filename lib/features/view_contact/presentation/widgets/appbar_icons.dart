import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/components/common_icon_button.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:flutter/material.dart';

List<Widget> appBarIconsOnContactView = [
  commonIconButton(
    icon: Icons.edit_outlined,
    onPressed: () {
      navigatorKey.currentState?.pushNamed(AppRoutesName.editContact);
    },
  ),
  commonIconButton(
    icon: Icons.star_outline,
    onPressed: () {
      MessageShowhelper.showSnackbar(snackBarContent: "Contact added to favorites");
    },
  ),
  PopupMenuButton(
    position: PopupMenuPosition.under,
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          onTap: () {
            MessageShowhelper.showDialogBox(
              dialogTitle: "Delete contact",
              dialogContent: "Are you sure about deleting this contact?",
              actionButtonName: "Delete",
              buttonActionMethod: () {
                navigatorKey.currentState?.pop();
              },
            );
          },
          child: const TextWidgetCommon(
            text: "Delete",
          ),
        ),
      ];
    },
  ),
];
