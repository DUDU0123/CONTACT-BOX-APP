import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/repository/cache_contact_repo/cache_contact_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetCacheContactDataUseCase implements Usecase<List<ContactEntity>, Null> {
  final CacheContactRepo cacheContactRepo;
  GetCacheContactDataUseCase({
    required this.cacheContactRepo,
  });
  @override
  Future<Either<Failure, List<ContactEntity>>> call(
      {required Null params}) async {
    return await cacheContactRepo.getAllContacts();
  }
}
