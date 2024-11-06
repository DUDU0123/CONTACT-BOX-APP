import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/repository/contact_repo/contact_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddContactUsecase implements Usecase<bool, ContactEntity> {
  final ContactRepository contactRepository;
  AddContactUsecase({
    required this.contactRepository,
  });
  @override
  Future<Either<Failure, bool>> call({required ContactEntity params}) async {
    return await contactRepository.addContact(contact: params);
  }
}
