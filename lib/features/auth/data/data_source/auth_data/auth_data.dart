import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:contact_box/core/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthData {
  Future<void> makeGoogleSignIn();
  Future<bool> signOutUser();
  void setAuthUser({required bool isLoggedIn});
  Future<bool> checkUserLoggedIn();
}

class AuthDataImpl implements AuthData {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  AuthDataImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  @override
  Future<void> makeGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled the sign-in

      // Retrieve the authentication tokens
      final GoogleSignInAuthentication gAuth = await googleUser.authentication;

      // Check for null tokens
      if (gAuth.accessToken == null || gAuth.idToken == null) {
        throw ServerException(message: "Authentication tokens are null");
      }

      // Create Firebase credential using Google tokens
      final oAuthCred = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCred =
          await firebaseAuth.signInWithCredential(oAuthCred);

      if (userCred.user != null) {
        // Create UserModel instance to store in Firestore
        final userModel = UserModel(
          userId: userCred.user?.uid,
          idToken: gAuth.idToken,
          accessToken: gAuth.accessToken,
          userEmail: googleUser.email,
          userName: googleUser.displayName,
          photoUrl: googleUser.photoUrl,
        );

        // Save user model to Firestore
        await firebaseFirestore
            .collection(usersCollection)
            .doc(userCred.user?.uid)
            .set(userModel.toJson());
            setAuthUser(isLoggedIn: true);
      } else {
        throw ServerException(message: "User is null cannot create account");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  void setAuthUser({required bool isLoggedIn}) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(isUserLoggedInKey, isLoggedIn);
  }

  @override
  Future<bool> signOutUser() async {
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      setAuthUser(isLoggedIn: false);
      return true;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> checkUserLoggedIn() async {
    try {
      final isLoggedIn = await CommonFunctions.getAuthUser();
      if (isLoggedIn != null) {
        return isLoggedIn;
      } else {
        return false;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
