import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/repository/contact_repo/contact_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllContactsUsecase implements Usecase<Stream<List<ContactEntity>>, Null> {
  final ContactRepository contactRepository;
  GetAllContactsUsecase({
    required this.contactRepository,
  });
  @override
  Future<Either<Failure, Stream<List<ContactEntity>>>> call({required Null params}) async{
    return await contactRepository.getAllContacts();
  }
  
}
