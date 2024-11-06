part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}
class GetAllFavoritesEvent extends FavoriteEvent{

}
class RemoveFromFavoriteEvent extends FavoriteEvent {
  final String favId;
  const RemoveFromFavoriteEvent({
    required this.favId,
  });
  @override
  List<Object> get props => [favId];
}
class AddToFavoriteEvent extends FavoriteEvent {
  final FavoriteEntity favoriteContact;
  const AddToFavoriteEvent({
    required this.favoriteContact,
  });
  @override
  List<Object> get props => [favoriteContact,];
}
class RemoveByContactId extends FavoriteEvent {
  final String? id;
  const RemoveByContactId({
    required this.id,
  });
  @override
  List<Object> get props => [id??'',];
}
class CheckIsInFav extends FavoriteEvent {
  final String? id;
  const CheckIsInFav({
    required this.id,
  });
  @override
  List<Object> get props => [id??'',];
}
