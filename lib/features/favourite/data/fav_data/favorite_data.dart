import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/core/service_locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:contact_box/core/exceptions/exceptions.dart';
import 'package:contact_box/features/favourite/data/model/fav_model.dart';

abstract interface class FavoriteData {
  Future<bool> addToFavorite({required FavoriteModel favModel});
  Stream<List<FavoriteModel>> getAllFavorites();
  Future<bool> removeFromFavorite({required String favModelId});
}

class FavoriteDataImpl implements FavoriteData {
  final FirebaseFirestore firebaseFirestore;
  FavoriteDataImpl({
    required this.firebaseFirestore,
  });
  @override
  Future<bool> addToFavorite({required FavoriteModel favModel}) async {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) return false;
      final docRef = await firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(favoritesCollection)
          .add(
            favModel.toJson(),
          );
      final updatedModel = favModel.copyWith(
        favId: docRef.id,
      );
      await firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(favoritesCollection)
          .doc(docRef.id)
          .update(
            updatedModel.toJson(),
          );
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<List<FavoriteModel>> getAllFavorites() {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) {
        throw ServerException(message: "Current user is null");
      }
      return firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(favoritesCollection)
          .snapshots()
          .map(
            (data) => data.docs
                .map(
                  (doc) => FavoriteModel.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> removeFromFavorite({required String favModelId}) async {
    try {
      final currentUser = serviceLocator<FirebaseAuth>().currentUser;
      if (currentUser == null) return false;
      await firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(favoritesCollection)
          .doc(favModelId)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
