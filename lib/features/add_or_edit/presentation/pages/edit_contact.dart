import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/enum/enums.dart';
import 'package:contact_box/features/add_or_edit/presentation/widgets/common_contact_manage_page.dart';
import 'package:flutter/material.dart';

class EditContact extends StatelessWidget {
  const EditContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidgetCommon(text: 'Person Name'),
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
      body: const CommonContactManagePage(
        pageType: PageType.contactEditPage,
      ),
    );
  }
}
