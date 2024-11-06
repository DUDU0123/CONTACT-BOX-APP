import 'package:contact_box/core/exceptions/exceptions.dart';
import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/features/auth/data/data_source/auth_data/auth_data.dart';
import 'package:contact_box/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthData authData;
  AuthRepoImpl({
    required this.authData,
  });
  @override
  Future<Either<Failure, void>> makeGoogleSignIn() async{
    try {
      final res = await authData.makeGoogleSignIn();
      return right(res);
    }on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e){
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOutUser() async {
     try {
      final isSignedOut = await authData.signOutUser();
      return right(isSignedOut);
    }on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e){
      return left(Failure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> checkUserLoggedIn() async {
    try {
      final isLoggedIn = await authData.checkUserLoggedIn();
      return right(isLoggedIn);
    }on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e){
      return left(Failure(message: e.toString()));
    }
  }
  
}
