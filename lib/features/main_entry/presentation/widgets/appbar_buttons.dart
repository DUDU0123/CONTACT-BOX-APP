import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/common_functions.dart';
import 'package:contact_box/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';


List<Widget> contactHomeAppBarIcons() {
  return [
    StreamBuilder<UserModel?>(
        stream: CommonFunctions.getCurrentUserDataAsStream(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              if (snapshot.data != null) {
                navigatorKey.currentState?.pushNamed(
                  AppRoutesName.userProfile,
                  arguments: snapshot.data!,
                );
              }
            },
            child: CircleAvatar(
                radius: 15,
                child: snapshot.data != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          snapshot.data!.photoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const TextWidgetCommon(text: "U");
                          },
                        ),
                      )
                    : const TextWidgetCommon(text: "U")),
          );
        }),
    kWidth10,
  ];
}
