import 'package:contact_box/core/components/text_field_common.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/enum/enums.dart';
import 'package:contact_box/core/utils/same_border.dart';
import 'package:contact_box/features/add_or_edit/presentation/widgets/contact_person_image_select_widget.dart';
import 'package:flutter/material.dart';

class CommonContactManagePage extends StatefulWidget {
  const CommonContactManagePage({super.key, required this.pageType});
  final PageType pageType;

  @override
  State<CommonContactManagePage> createState() =>
      _CommonContactManagePageState();
}

class _CommonContactManagePageState extends State<CommonContactManagePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            kHeight15,
            const ContactPersonImageSelectWidget(),
            kHeight20,
            TextFieldCommon(
              keyboardType: TextInputType.text,
              controller: firstNameController,
              labelText: "Enter First Name",
              hintText: "First Name",
              border: sameBorder(),
            ),
            kHeight15,
            TextFieldCommon(
              keyboardType: TextInputType.text,
              controller: lastNameController,
              labelText: "Enter Last Name",
              hintText: "Last Name",
              border: sameBorder(),
            ),
            kHeight15,
            TextFieldCommon(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              labelText: "Enter Phone Number",
              hintText: "Phone number",
              border: sameBorder(),
            ),
            kHeight15,
            TextFieldCommon(
              maxLines: 5,
              minLines: 5,
              keyboardType: TextInputType.text,
              controller: addressController,
              hintText: "Enter Address",
              border: sameBorder(),
            ),
            kHeight20,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkishBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () {
                if (widget.pageType == PageType.contactAddPage) {
                } else {}
              },
              child: const TextWidgetCommon(
                text: "Save",
              ),
            ),
            kHeight15,
          ],
        ),
      ),
    );
  }
}
