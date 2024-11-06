import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/enum/enums.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:provider/provider.dart';

class ContactMethods {
  static void addOrEditContact({
    required String? fName,
    required String? lName,
    required String number,
    required String? address,
    ContactEntity? contact,
    required PageType pageType,
    String? countryIsoCode,
    String? countryCode,
  }) {
    if (pageType == PageType.contactAddPage) {
      if (fName == null || address == null) {
        MessageShowhelper.showSnackbar(
            snackBarContent: "Fill all fields before saving");
      }
      if (fName!.isNotEmpty && number.isNotEmpty && address!.isNotEmpty) {
        final newContact = ContactEntity(
          contactPersonAddress: address,
          contactPersonFName: fName,
          contactPersonLName: lName,
          contactPersonFullName: '$fName $lName',
          contactPersonNumber: number,
          countryIsoCode: countryIsoCode,
          countryCodeInNumber: countryCode,
        );
        navigatorKey.currentContext!
            .read<ContactBloc>()
            .add(AddContactEvent(newContact: newContact));
        MessageShowhelper.showSnackbar(snackBarContent: "Saved successfully");
      } else {
        MessageShowhelper.showSnackbar(
            snackBarContent: "Fill all fields before saving");
      }
    } else {
      if (contact != null) {
        ContactEntity updatedContact = ContactModel(
          contactId: contact.contactId,
          contactPersonAddress: address ?? contact.contactPersonAddress,
          contactPersonFName: fName ?? contact.contactPersonFName,
          contactPersonLName: lName ?? contact.contactPersonLName,
          contactPersonFullName:
              '$fName $lName' ?? contact.contactPersonFullName,
          contactPersonNumber: number,
          countryIsoCode: countryIsoCode??contact.countryIsoCode,
          countryCodeInNumber: countryCode??contact.countryCodeInNumber,
        );
        navigatorKey.currentContext!
            .read<ContactBloc>()
            .add(EditContactEvent(updatedContact: updatedContact));
        MessageShowhelper.showSnackbar(snackBarContent: "Saved successfully");
      } else {
        MessageShowhelper.showSnackbar(snackBarContent: "Cannot save contact");
      }
    }
  }
}
