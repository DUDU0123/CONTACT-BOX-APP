import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ContactRepository {
  Future<Either<Failure, bool>> addContact({
    required ContactEntity contact,
  });
  Future<Either<Failure, bool>> editContact({
    required ContactEntity updatedContact,
  });
  Future<Either<Failure, bool>> deleteContact({
    required String contactId,
  });
  Future<Either<Failure, Stream<List<ContactEntity>>>> getAllContacts();
}
