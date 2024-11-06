import 'package:contact_box/core/components/common_contact_avatar.dart';
import 'package:contact_box/core/components/common_loading.dart';
import 'package:contact_box/core/components/empty_text.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/core/utils/native_action_methods.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/appbar_icons.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/common_action_button_view.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/common_tile_container.dart';
import 'package:flutter/material.dart';

class ViewContact extends StatelessWidget {
  const ViewContact({super.key});

  @override
  Widget build(BuildContext context) {
    ContactEntity contactEntity =
        ModalRoute.of(context)?.settings.arguments as ContactEntity;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<ContactEntity?>(
            stream: contactEntity.contactId != null
                ? CommonFunctions.getContactById(
                    contactId: contactEntity.contactId!)
                : null,
            builder: (context, snapshot) {
              final contact = snapshot.data;
              return TextWidgetCommon(
                text: contact != null
                    ? "${contact.contactPersonFName} ${contact.contactPersonLName}"
                    : "No name",
              );
            }),
        actions: appBarIconsOnContactView(contact: contactEntity),
      ),
      body: SizedBox(
        width: screenWidth(context: context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: StreamBuilder<ContactEntity?>(
                stream: contactEntity.contactId != null
                    ? CommonFunctions.getContactById(
                        contactId: contactEntity.contactId!)
                    : null,
                builder: (context, snapshot) {
                  final contact = snapshot.data;
                  if (contact == null) {
                    return commonLoading();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonContactAvatar(
                        avatarContainerSize: 160,
                        fontSize: 80,
                        centerAlphabet: contact.contactPersonFName?[0],
                      ),
                      kHeight10,
                      TextWidgetCommon(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text:
                            "${contact.contactPersonFName} ${contact.contactPersonLName}" ??
                                "User name",
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
                            onTap: () async {
                              if (contact.contactPersonNumber != null) {
                                await NativeActionMethods.makePhoneCall(
                                    contact.contactPersonNumber!);
                              } else {
                                MessageShowhelper.showSnackbar(
                                    snackBarContent:
                                        "Cannot make call to this number");
                              }
                            },
                          ),
                          kWidth15,
                          CommonActionButtonInView(
                            actionName: "Message",
                            icon: Icons.message,
                            onTap: () async {
                              if (contact.contactPersonNumber != null) {
                                await NativeActionMethods.openMessageApp(
                                    phoneNumber: contact.contactPersonNumber!);
                              } else {
                                MessageShowhelper.showSnackbar(
                                    snackBarContent:
                                        "Cannot open message app for this number");
                              }
                            },
                          ),
                        ],
                      ),
                      kHeight35,
                      CommonTileContainer(
                        infoName: "Contact Info",
                        isTrailingNeeded: true,
                        title: contact.contactPersonNumber ?? "",
                        phoneNumber: contact.contactPersonNumber,
                        subtitle: "Mobile",
                        leadingIcon: Icons.phone_android,
                      ),
                      kHeight15,
                      CommonTileContainer(
                        infoName: "Address",
                        isTrailingNeeded: false,
                        title: contact.contactPersonAddress ?? '',
                        leadingIcon: Icons.home,
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
