import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? contactId;
  final String? contactPersonFName;
  final String? contactPersonLName;
  final String? contactPersonImage;
  final String? contactPersonNumber;
  final String? contactPersonAddress;
  final String? contactPersonFullName;
  final String? countryCode;
  const ContactEntity({
    this.contactId,
    this.contactPersonFName,
    this.contactPersonLName,
    this.contactPersonFullName,
    this.contactPersonImage,
    this.contactPersonNumber,
    this.contactPersonAddress,
    this.countryCode,
  });

  @override
  List<Object?> get props {
    return [
      contactId,
      contactPersonFName,
      contactPersonLName,
      contactPersonImage,
      contactPersonNumber,
      contactPersonAddress,
      countryCode,
      contactPersonFullName,
    ];
  }
}
