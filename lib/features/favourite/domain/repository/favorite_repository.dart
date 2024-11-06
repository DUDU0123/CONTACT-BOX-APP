import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FavoriteRepository {
  Future<Either<Failure, bool>> addToFavorite({required FavoriteEntity favModel});
  Future<Either<Failure, Stream<List<FavoriteEntity>>>> getAllFavorites();
  Future<Either<Failure, bool>> removeFromFavorite({required String favModelId});
}