import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? photoUrl;
  final String? accessToken;
  final String? idToken;
  const UserEntity({
    this.userId,
    this.userName,
    this.userEmail,
    this.photoUrl,
    this.accessToken,
    this.idToken,
  });

  @override
  List<Object?> get props {
    return [
      userId,
      userName,
      userEmail,
      photoUrl,
      accessToken,
      idToken,
    ];
  }
}
