import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GoogleSigninUsecase implements Usecase<void, Null> {
  final AuthRepository authRepository;
  GoogleSigninUsecase({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, void>> call({required Null params})async {
   return await authRepository.makeGoogleSignIn();
  }
}
