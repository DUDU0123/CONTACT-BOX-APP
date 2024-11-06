import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/features/auth/domain/entity/user_entity.dart';
import 'package:contact_box/features/user_profile/presentation/widgets/common_user_detail_container.dart';
import 'package:contact_box/features/user_profile/presentation/widgets/logout_action_button.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserEntity user =
        ModalRoute.of(context)?.settings.arguments as UserEntity;
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetCommon(text: user.userName ?? "No name"),
      ),
      body: SizedBox(
        width: screenWidth(context: context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    user.photoUrl ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const TextWidgetCommon(text: "U");
                    },
                  ),
                ),
              ),
              TextWidgetCommon(
                text: user.userName ?? "No Name",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              kHeight40,
              commonUserDetailContainer(
                  value: user.userName ?? "No Name", label: "Name"),
              kHeight15,
              commonUserDetailContainer(
                  value: user.userEmail ?? "No Email", label: "Email"),
              kHeight15,
              const LogOutActionButton(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
