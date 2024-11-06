import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/favourite/domain/repository/favorite_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveOneFavoriteUsecase implements Usecase<bool, String> {
  final FavoriteRepository favoriteRepository;
  RemoveOneFavoriteUsecase({
    required this.favoriteRepository,
  });
  @override
  Future<Either<Failure, bool>> call({required String params})async {
   return await favoriteRepository.removeFromFavorite(favModelId: params);
  }
}
