import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final String? favId;
  final String? favContactId;
  const FavoriteEntity({
    this.favId,
    this.favContactId,
  });

  @override
  List<Object?> get props => [
        favId,
        favContactId,
      ];
}
