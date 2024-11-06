import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/core/service_locator/service_locator.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/auth/data/model/user_model.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';
import 'package:contact_box/features/contacts/domain/entity/contact_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonFunctions {
  static Future<bool?> getAuthUser() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(isUserLoggedInKey);
  }

  static Future<UserModel?> getCurrentUserData() async {
    try {
      final docRef = await serviceLocator<FirebaseFirestore>()
          .collection(usersCollection)
          .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
          .get();
      return UserModel.fromJson(docRef.data()!);
    } catch (e) {
      MessageShowhelper.showSnackbar(snackBarContent: e.toString());
      return null;
    }
  }

  static Stream<UserModel?>? getCurrentUserDataAsStream() {
    try {
      return serviceLocator<FirebaseFirestore>()
          .collection(usersCollection)
          .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
          .snapshots()
          .map((data) => UserModel.fromJson(data.data()!));
    } catch (e) {
      MessageShowhelper.showSnackbar(snackBarContent: e.toString());
      return null;
    }
  }

  static Stream<ContactEntity?>? getContactById({required String? contactId}) {
    try {
      if (contactId != null) {
        return serviceLocator<FirebaseFirestore>()
            .collection(usersCollection)
            .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
            .collection(contactsCollection)
            .doc(contactId)
            .snapshots()
            .map((data) {
          final contactData = data.data();
          if (contactData != null) {
            return ContactModel.fromJson(contactData);
          } else {
            // If no contact data is found, return null
            return null;
          }
        });
      }
      return null;
    } catch (e) {
      MessageShowhelper.showSnackbar(snackBarContent: e.toString());
      return null;
    }
  }

  static Future<bool> isInFavorite({required String contactId}) async {
    try {
      final querySnapshot = await serviceLocator<FirebaseFirestore>()
          .collection(usersCollection)
          .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
          .collection(favoritesCollection)
          .where(dbFavContactId, isEqualTo: contactId)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteFavByContactId({required String? contactId}) async {
    try {
      final querySnapshot = await serviceLocator<FirebaseFirestore>()
          .collection(usersCollection)
          .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
          .collection(favoritesCollection)
          .where(dbFavContactId, isEqualTo: contactId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await serviceLocator<FirebaseFirestore>()
            .collection(usersCollection)
            .doc(serviceLocator<FirebaseAuth>().currentUser?.uid)
            .collection(favoritesCollection)
            .doc(docId)
            .delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
