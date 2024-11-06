import 'package:contact_box/features/favourite/data/model/fav_model.dart';
import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/exceptions/exceptions.dart';
import 'package:contact_box/features/favourite/data/fav_data/favorite_data.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:contact_box/features/favourite/domain/repository/favorite_repository.dart';
import 'package:fpdart/fpdart.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteData favoriteData;
  FavoriteRepositoryImpl({
    required this.favoriteData,
  });
  @override
  Future<Either<Failure, bool>> addToFavorite(
      {required FavoriteEntity favModel}) async {
    try {
      FavoriteModel favoriteModel = FavoriteModel(
        favContactId: favModel.favContactId,
      );
      final result = await favoriteData.addToFavorite(favModel: favoriteModel);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<FavoriteEntity>>>>
      getAllFavorites() async {
    try {
      final result = favoriteData.getAllFavorites();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromFavorite(
      {required String favModelId}) async {
    try {
      final result =
          await favoriteData.removeFromFavorite(favModelId: favModelId);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
