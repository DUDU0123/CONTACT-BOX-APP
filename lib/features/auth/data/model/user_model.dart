import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.accessToken,
    super.idToken,
    super.photoUrl,
    super.userEmail,
    super.userName,
    super.userId,
  });

   factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json[dbAccessToken] as String?,
      idToken: json[dbIdToken] as String?,
      photoUrl: json[dbPhotoUrl] as String?,
      userEmail: json[dbUserEmail] as String?,
      userName: json[dbUserName] as String?,
      userId: json[dbUserId] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      dbAccessToken: accessToken,
      dbIdToken: idToken,
      dbPhotoUrl: photoUrl,
      dbUserEmail: userEmail,
      dbUserName: userName,
      dbUserId: userId,
    };
  }


  UserModel copyWith({
    String? accessToken,
    String? idToken,
    String? photoUrl,
    String? userEmail,
    String? userName,
    String? userId,
  }) {
    return UserModel(
      accessToken: accessToken ?? this.accessToken,
      idToken: idToken ?? this.idToken,
      photoUrl: photoUrl ?? this.photoUrl,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
    );
  }
}

