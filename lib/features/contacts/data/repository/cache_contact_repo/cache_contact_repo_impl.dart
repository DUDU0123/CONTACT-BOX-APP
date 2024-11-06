import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/features/contacts/data/data_sources/cache_contact_data.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/repository/cache_contact_repo/cache_contact_repo.dart';
import 'package:fpdart/fpdart.dart';

class CacheContactRepoImpl implements CacheContactRepo {
  final CacheContactData cacheContactData;
  CacheContactRepoImpl({
    required this.cacheContactData,
  });
  @override
  Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
    try {
      final List<ContactEntity> contactList =
          await cacheContactData.getAllContacts();
      return right(contactList);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
