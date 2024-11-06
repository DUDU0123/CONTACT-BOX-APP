import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/features/favourite/domain/entity/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    super.favContactId,
    super.favId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favId: json[dbFavId] as String?,
      favContactId: json[dbFavContactId] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      dbFavId: favId,
      dbFavContactId: favContactId,
    };
  }

  FavoriteModel copyWith({
    String? favId,
    String? favContactId,
  }) {
    return FavoriteModel(
      favContactId: favContactId ?? this.favContactId,
      favId: favId ?? this.favId,
    );
  }
}
