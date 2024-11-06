import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/contacts/domain/repository/contact_repo/contact_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteContactUsecase implements Usecase<bool, String> {
  final ContactRepository contactRepository;
  DeleteContactUsecase({
    required this.contactRepository,
  });
  @override
  Future<Either<Failure, bool>> call({required String params}) async {
    return await contactRepository.deleteContact(contactId: params);
  }
}
