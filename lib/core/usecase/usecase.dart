import 'package:contact_box/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params>{
 Future<Either<Failure, SuccessType>> call({required Params params});
}