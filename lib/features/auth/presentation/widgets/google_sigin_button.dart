import 'package:contact_box/core/components/text_widget_common.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AuthenticationBloc>().add(SignInUserEvent());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kBlack,
            boxShadow: [
              BoxShadow(
                color: kWhite.withOpacity(0.4),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(1, 0),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.network(
              height: 40,
              width: 40,
              "https://static.cdnlogo.com/logos/g/38/google-icon.svg",
            ),
            kWidth15,
            const TextWidgetCommon(
              text: "Sign In With Google",
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
