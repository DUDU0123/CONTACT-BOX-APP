import 'package:contact_box/core/error/failure.dart';
import 'package:contact_box/core/usecase/usecase.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:contact_box/features/favourite/domain/repository/favorite_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddToFavoriteUsecase implements Usecase<bool, FavoriteEntity> {
  final FavoriteRepository favoriteRepository;
  AddToFavoriteUsecase({
    required this.favoriteRepository,
  });
  @override
  Future<Either<Failure, bool>> call({required FavoriteEntity params}) async{
    return await favoriteRepository.addToFavorite(favModel: params);
  }
}
