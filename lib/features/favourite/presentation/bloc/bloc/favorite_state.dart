part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  const FavoriteState( {
    this.favoriteList,
    this.isInFavorite = false,
  });
  final Stream<List<FavoriteEntity>>? favoriteList;
  final bool isInFavorite;

  FavoriteState copyWith({
    Stream<List<FavoriteEntity>>? favoriteList,
     bool? isInFavorite,
  }){
    return FavoriteState(
      favoriteList: favoriteList,
       isInFavorite: isInFavorite??this.isInFavorite
    );
  }
  @override
  List<Object> get props => [
        favoriteList ?? [],isInFavorite,
      ];
}

final class FavoriteInitial extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  final String message;
  const FavoriteErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [
        message,
      ];
}

class FavoriteLoadingState extends FavoriteState {}
