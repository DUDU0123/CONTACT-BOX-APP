import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:contact_box/features/contacts/domain/repository/contact_repo/contact_repository.dart';
import 'package:fpdart/fpdart.dart';

class EditContactUsecase implements Usecase<bool, ContactEntity> {
  final ContactRepository contactRepository;
  EditContactUsecase({
    required this.contactRepository,
  });
  @override
  Future<Either<Failure, bool>> call({required ContactEntity params}) async {
    return await contactRepository.editContact(updatedContact: params);
  }
}
