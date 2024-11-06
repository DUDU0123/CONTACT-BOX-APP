import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? contactId;
  final String? contactPersonFName;
  final String? contactPersonLName;
  final String? contactPersonImage;
  final String? contactPersonNumber;
  final String? contactPersonAddress;
  final String? contactPersonFullName;
  final String? countryIsoCode;
  final String? countryCodeInNumber;
  const ContactEntity({
    this.contactId,
    this.contactPersonFName,
    this.contactPersonLName,
    this.contactPersonFullName,
    this.countryCodeInNumber,
    this.contactPersonImage,
    this.contactPersonNumber,
    this.contactPersonAddress,
    this.countryIsoCode,
  });

  @override
  List<Object?> get props {
    return [
      contactId,
      contactPersonFName,
      contactPersonLName,
      contactPersonImage,
      contactPersonNumber,
      contactPersonAddress,countryCodeInNumber,
      countryIsoCode,
      contactPersonFullName,
    ];
  }
}
