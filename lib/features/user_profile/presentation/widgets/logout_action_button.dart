import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:contact_box/features/view_contact/presentation/widgets/common_action_button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogOutActionButton extends StatelessWidget {
  const LogOutActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          if (!state.isUserLoggedIn) {
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutesName.auth,
              (route) => false,
            );
          }
        }
      },
      child: CommonActionButtonInView(
        icon: Icons.power_settings_new_sharp,
        actionName: "LogOut",
        onTap: () {
          MessageShowhelper.showDialogBox(
            dialogTitle: "Log out",
            dialogContent: "Are you sure about log out?",
            actionButtonName: "LogOut",
            buttonActionMethod: () {
              context
                  .read<AuthenticationBloc>()
                  .add(SignOutUserEvent());
              navigatorKey.currentState?.pop();
            },
          );
        },
      ),
    );
  }
}
