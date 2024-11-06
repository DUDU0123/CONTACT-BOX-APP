import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:contact_box/features/auth/presentation/pages/authentication_page.dart';
import 'package:contact_box/features/main_entry/presentation/pages/main_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashIntro extends StatefulWidget {
  const SplashIntro({super.key});

  @override
  State<SplashIntro> createState() => _SplashIntroState();
}

class _SplashIntroState extends State<SplashIntro> {
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(CheckUserLoggedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccessState) {
            if (state.isUserLoggedIn) {
              return const MainEntry();
            } else {
              return const AuthenticationPage();
            }
          } else {
            return const AuthenticationPage();
          }
        },
      ),
    );
  }
}
