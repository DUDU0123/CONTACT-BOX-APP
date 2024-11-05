import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/enum/enums.dart';
import 'package:contact_box/features/add_or_edit/presentation/widgets/common_contact_manage_page.dart';
import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: const TextWidgetCommon(text: "Add Contact"),
        actions: [
          TextButton(
            onPressed: () {
              navigatorKey.currentState?.pop();
            },
            child: const TextWidgetCommon(
              text: "Cancel",
              textColor: kWhite,
            ),
          )
        ],
      ),
      body: CommonContactManagePage(
        pageType: PageType.contactAddPage,
      ),
    );
  }
}

