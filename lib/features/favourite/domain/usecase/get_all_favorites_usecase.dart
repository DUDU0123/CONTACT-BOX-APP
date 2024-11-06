import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:contact_box/features/favourite/domain/repository/favorite_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllFavoritesUsecase implements Usecase<Stream<List<FavoriteEntity>>, Null> {
  final FavoriteRepository favoriteRepository;
  GetAllFavoritesUsecase({
    required this.favoriteRepository,
  });
  @override
  Future<Either<Failure, Stream<List<FavoriteEntity>>>> call({required Null params})async {
    return await favoriteRepository.getAllFavorites();
  }
}
