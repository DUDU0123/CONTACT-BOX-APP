import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignoutUsecase implements Usecase<bool, Null> {
  final AuthRepository authRepository;
  SignoutUsecase({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, bool>> call({required Null params})async {
   return await authRepository.signOutUser();
  }
}
