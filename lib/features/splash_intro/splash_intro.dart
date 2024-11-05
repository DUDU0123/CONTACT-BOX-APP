import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/height_width.dart';
import 'package:flutter/material.dart';

class SplashIntro extends StatefulWidget {
  const SplashIntro({super.key});

  @override
  State<SplashIntro> createState() => _SplashIntroState();
}

class _SplashIntroState extends State<SplashIntro> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        navigatorKey.currentState?.pushNamed(AppRoutesName.mainEntry);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "assets/contact_box.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
