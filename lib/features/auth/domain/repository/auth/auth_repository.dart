import 'package:contact_box/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, void>> makeGoogleSignIn();
  Future<Either<Failure, bool>> signOutUser();
  Future<Either<Failure, bool>> checkUserLoggedIn();
}