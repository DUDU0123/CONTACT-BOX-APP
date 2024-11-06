import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/exceptions/exceptions.dart';
import 'package:contact_box/features/contacts/data/data_sources/contact_data.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/repository/contact_repo/contact_repository.dart';
import 'package:fpdart/fpdart.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactData contactData;
  ContactRepositoryImpl({
    required this.contactData,
  });
  @override
  Future<Either<Failure, bool>> addContact(
      {required ContactEntity contact}) async {
    try {
      final contactModel = ContactModel(
        contactPersonAddress: contact.contactPersonAddress,
        contactPersonImage: contact.contactPersonImage,
        contactPersonFName: contact.contactPersonFName,
        contactPersonLName: contact.contactPersonLName,
        contactPersonNumber: contact.contactPersonNumber,
        contactPersonFullName: contact.contactPersonFullName,
        countryIsoCode: contact.countryIsoCode,
        countryCodeInNumber: contact.countryCodeInNumber,
      );
      final result = await contactData.addContact(contactModel: contactModel);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteContact(
      {required String contactId}) async {
    try {
      final result = await contactData.deleteContact(contactId: contactId);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> editContact(
      {required ContactEntity updatedContact}) async {
    try {
      final contactModel = ContactModel(
        contactId: updatedContact.contactId,
        contactPersonAddress: updatedContact.contactPersonAddress,
        contactPersonImage: updatedContact.contactPersonImage,
        contactPersonFName: updatedContact.contactPersonFName,
        contactPersonLName: updatedContact.contactPersonLName,
        contactPersonNumber: updatedContact.contactPersonNumber,
        contactPersonFullName: updatedContact.contactPersonFullName,
        countryIsoCode: updatedContact.countryIsoCode,
        countryCodeInNumber: updatedContact.countryCodeInNumber
      );
      final result = await contactData.editContact(updatedModel: contactModel);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<ContactEntity>>>> getAllContacts() async {
    try {
      final result = contactData.getAllContacts();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
