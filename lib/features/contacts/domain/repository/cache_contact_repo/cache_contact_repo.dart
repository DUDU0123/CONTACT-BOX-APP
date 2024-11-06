import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CacheContactRepo {
  Future<Either<Failure, List<ContactEntity>>> getAllContacts();
}