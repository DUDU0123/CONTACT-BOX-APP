import 'dart:developer';

import 'package:contact_box/core/components/text_field_common.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/enum/enums.dart';
import 'package:contact_box/core/utils/same_border.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contact_box/features/contacts/presentation/utils/contact_methods.dart';
import 'package:contact_box/features/contacts/presentation/widgets/contact_person_image_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CommonContactManagePage extends StatefulWidget {
  const CommonContactManagePage({
    super.key,
    required this.pageType,
    this.contact,
  });
  final PageType pageType;
  final ContactEntity? contact;

  @override
  State<CommonContactManagePage> createState() =>
      _CommonContactManagePageState();
}

class _CommonContactManagePageState extends State<CommonContactManagePage> {
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  @override
  void initState() {
    if (widget.contact != null) {
      firstNameController?.text = widget.contact!.contactPersonFName!;
      lastNameController?.text = widget.contact!.contactPersonLName!;
      phoneNumberController.text = widget.contact!.contactPersonNumber!;
      addressController?.text = widget.contact!.contactPersonAddress!;
    }
    super.initState();
  }

  @override
  void dispose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    phoneNumberController.dispose();
    addressController?.dispose();
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
            ContactPersonImageSelectWidget(
              centerAlphabet: widget.pageType == PageType.contactAddPage
                  ? 'U'
                  : widget.contact?.contactPersonFName != null
                      ? widget.contact!.contactPersonFName!.isNotEmpty
                          ? widget.contact?.contactPersonFName![0]
                          : 'U'
                      : 'U',
            ),
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
            BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                return IntlPhoneField(
                  initialValue: widget.contact != null
                      ? widget.contact!.countryCodeInNumber != null
                          ? widget.contact?.contactPersonNumber?.substring(
                              widget.contact!.countryCodeInNumber!.length,
                              widget.contact?.contactPersonNumber?.length,
                            )
                          : null
                      : null,
                  initialCountryCode: widget.contact?.countryIsoCode,
                  decoration: InputDecoration(
                    border: sameBorder(),
                    hintText: "Phone number",
                    labelText: "Enter Phone Number",
                  ),
                  onChanged: (value) {
                    // Update the Bloc with the new country code and ISO code
                    context.read<ContactBloc>().add(GetCountryCodeEvent(
                      numberOnly: value.number,
                        countryIsoCode: value.countryISOCode,
                        countryCode: value.countryCode));
                        log(value.toString());

                    phoneNumberController.text = value.completeNumber;
                  },
                );
              },
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
            BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkishBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  onPressed: () {
                    String? address = addressController?.text;
                    String? firstName = firstNameController?.text;
                    String? lastName = lastNameController?.text;
                    String number = phoneNumberController.text;

                    // Determine the correct country code and ISO code to pass
                    String? finalCountryIsoCode =
                        widget.pageType == PageType.contactEditPage
                            ? (widget.contact?.countryIsoCode ==
                                    state.countryIsoCode
                                ? widget.contact?.countryIsoCode
                                : state.countryIsoCode)
                            : state.countryIsoCode;

                    String? finalCountryCode =
                        widget.pageType == PageType.contactEditPage
                            ? (widget.contact?.countryCodeInNumber ==
                                    state.countryCode
                                ? widget.contact?.countryCodeInNumber
                                : state.countryCode)
                            : state.countryCode;
                    String? numberOnly =
                        widget.pageType == PageType.contactEditPage
                            ? (widget.contact?.contactPersonNumberWithoutCountryCode ==
                                    state.numberOnly
                                ? widget.contact?.contactPersonNumberWithoutCountryCode
                                : state.numberOnly)
                            : state.numberOnly;

                            log("Phone number: ${phoneNumberController.text} and $finalCountryCode");

                    ContactMethods.addOrEditContact(
                      countryIsoCode: finalCountryIsoCode,
                      countryCode: finalCountryCode,
                      fName: firstName,
                      lName: lastName,
                      numberOnly: numberOnly,
                      number: number,
                      address: address,
                      pageType: widget.pageType,
                      contact: widget.contact,
                    );
                  },
                  child: const TextWidgetCommon(
                    text: "Save",
                  ),
                );
              },
            ),
            kHeight15,
          ],
        ),
      ),
    );
  }
}
