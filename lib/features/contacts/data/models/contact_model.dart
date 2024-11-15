import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel(
      {super.contactId,
      super.contactPersonAddress,
      super.contactPersonImage,
      super.contactPersonFName,
      super.contactPersonLName,
      super.contactPersonNumber,
      super.countryCodeInNumber,
      super.contactPersonNumberWithoutCountryCode,
      super.countryIsoCode,
      super.contactPersonFullName});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        contactId: json[dbContactId] as String?,
        contactPersonAddress: json[dbContactPersonAddress] as String?,
        contactPersonImage: json[dbContactPersonImage] as String?,
        contactPersonFName: json[dbContactPersonFName] as String?,
        contactPersonLName: json[dbContactPersonLName] as String?,
        contactPersonNumber: json[dbContactPersonNumber] as String?,
        countryIsoCode: json[dbContactCountry] as String?,
        contactPersonFullName: json[dbContactFullName] as String?,
        countryCodeInNumber: json[dbCountryCodeInNumber] as String?,
        contactPersonNumberWithoutCountryCode:
            json[dbNumberWithoutCountryCode] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      dbContactId: contactId,
      dbContactPersonAddress: contactPersonAddress,
      dbContactPersonImage: contactPersonImage,
      dbContactPersonFName: contactPersonFName,
      dbContactPersonLName: contactPersonLName,
      dbContactPersonNumber: contactPersonNumber,
      dbContactCountry: countryIsoCode,
      dbContactFullName: contactPersonFullName,
      dbCountryCodeInNumber: countryCodeInNumber,
      dbNumberWithoutCountryCode: contactPersonNumberWithoutCountryCode,
    };
  }

  ContactModel copyWith({
    String? contactId,
    String? contactPersonAddress,
    String? contactPersonImage,
    String? contactPersonFName,
    String? contactPersonLName,
    String? countryIsoCode,
    String? contactPersonNumber,
    String? contactPersonFullName,
    String? countryCodeInNumber,
    String? contactPersonNumberWithoutCountryCode,
  }) {
    return ContactModel(
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      contactId: contactId ?? this.contactId,
      contactPersonAddress: contactPersonAddress ?? this.contactPersonAddress,
      contactPersonImage: contactPersonImage ?? this.contactPersonImage,
      contactPersonFName: contactPersonFName ?? this.contactPersonFName,
      contactPersonLName: contactPersonLName ?? this.contactPersonLName,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      contactPersonFullName:
          contactPersonFullName ?? this.contactPersonFullName,
      countryCodeInNumber: countryCodeInNumber ?? this.countryCodeInNumber,
      contactPersonNumberWithoutCountryCode:
          contactPersonNumberWithoutCountryCode ??
              this.contactPersonNumberWithoutCountryCode,
    );
  }
}
