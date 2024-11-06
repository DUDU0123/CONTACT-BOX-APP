import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/enum/enums.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/presentation/widgets/common_contact_manage_page.dart';
import 'package:flutter/material.dart';

class EditContact extends StatelessWidget {
  const EditContact({super.key});

  @override
  Widget build(BuildContext context) {
    ContactEntity contact = ModalRoute.of(context)?.settings.arguments as ContactEntity;
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetCommon(text:"${contact.contactPersonFName} ${contact.contactPersonLName}" ??'Person'),
      ),
      body:  CommonContactManagePage(
        pageType: PageType.contactEditPage,
        contact: contact,
      ),
    );
  }
}
