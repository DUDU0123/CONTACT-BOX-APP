import 'dart:developer';

import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/components/app_logo.dart';
import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/core/utils/message_show_helper.dart';
import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:contact_box/features/auth/presentation/widgets/google_sigin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationErrorState) {
              MessageShowhelper.showSnackbar(snackBarContent: state.message);
              log(state.message.toString());
            }
            if (state is AuthenticationSuccessState) {
              if (state.isUserLoggedIn) {
                navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  AppRoutesName.mainEntry,
                  (route) => false,
                );
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appLogo(),
              const TextWidgetCommon(
                textAlign: TextAlign.center,
                text: "Hey there!\nWelcome to ContactBox",
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              kHeight20,
              const GoogleSignInButton()
            ],
          ),
        ),
      ),
    );
  }
}
