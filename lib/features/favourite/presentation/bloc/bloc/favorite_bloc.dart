import 'dart:async';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';
import 'package:contact_box/features/favourite/domain/usecase/add_to_favorite_usecase.dart';
import 'package:contact_box/features/favourite/domain/usecase/get_all_favorites_usecase.dart';
import 'package:contact_box/features/favourite/domain/usecase/remove_one_favorite_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetAllFavoritesUsecase _getAllFavoritesUsecase;
  final AddToFavoriteUsecase _addToFavoriteUsecase;
  final RemoveOneFavoriteUsecase _removeOneFavoriteUsecase;
  FavoriteBloc(
      {required GetAllFavoritesUsecase getAllFavoritesUsecase,
      required AddToFavoriteUsecase addToFavoriteUsecase,
      required RemoveOneFavoriteUsecase removeOneFavoriteUsecase})
      : _getAllFavoritesUsecase = getAllFavoritesUsecase,
        _addToFavoriteUsecase = addToFavoriteUsecase,
        _removeOneFavoriteUsecase = removeOneFavoriteUsecase,
        super(FavoriteInitial()) {
    on<GetAllFavoritesEvent>(getAllFavoritesEvent);
    on<AddToFavoriteEvent>(addToFavoriteEvent);
    on<RemoveFromFavoriteEvent>(removeFromFavoriteEvent);
    on<RemoveByContactId>(removeByContactId);
    on<CheckIsInFav>(checkIsInFav);
  }

  FutureOr<void> getAllFavoritesEvent(
      GetAllFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoadingState());
    try {
      final res = await _getAllFavoritesUsecase(params: null);
      res.fold(
        (failure) {
          emit(FavoriteErrorState(message: failure.message));
        },
        (favList) {
          emit(FavoriteState(favoriteList: favList));
        },
      );
    } catch (e) {
      emit(FavoriteErrorState(message: e.toString()));
    }
  }

  Future<void> addToFavoriteEvent(
      AddToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final res = await _addToFavoriteUsecase(params: event.favoriteContact);
      res.fold(
        (failure) {
          emit(FavoriteErrorState(message: failure.message));
        },
        (result) {
          MessageShowhelper.showSnackbar(
              snackBarContent: "Contact added to favorites");
          add(GetAllFavoritesEvent());
        },
      );
    } catch (e) {
      emit(FavoriteErrorState(message: e.toString()));
    }
  }

  Future<void> removeFromFavoriteEvent(
      RemoveFromFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final res = await _removeOneFavoriteUsecase(params: event.favId);
      res.fold(
        (failure) {
          emit(FavoriteErrorState(message: failure.message));
        },
        (result) {
          add(GetAllFavoritesEvent());
        },
      );
    } catch (e) {
      emit(FavoriteErrorState(message: e.toString()));
    }
  }

  FutureOr<void> removeByContactId(
      RemoveByContactId event, Emitter<FavoriteState> emit) async {
    try {
      final val =
          await CommonFunctions.deleteFavByContactId(contactId: event.id);
      if (val) {
        add(GetAllFavoritesEvent());
      } else {}
    } catch (e) {
      emit(FavoriteErrorState(message: e.toString()));
    }
  }

  Future<void> checkIsInFav(
      CheckIsInFav event, Emitter<FavoriteState> emit) async {
    try {
      if (event.id != null) {
        final bool isInFavorite =
            await CommonFunctions.isInFavorite(contactId: event.id!);
        emit(state.copyWith(isInFavorite: isInFavorite));
      }
    } catch (e) {
      emit(FavoriteErrorState(message: e.toString()));
    }
  }
}
