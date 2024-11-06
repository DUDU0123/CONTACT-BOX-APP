import 'package:contact_box/config/routes/app_routes.dart';
import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/core/constants/app_keys.dart';
import 'package:contact_box/core/constants/colors.dart';
import 'package:contact_box/core/network/connection_checker.dart';
import 'package:flutter/material.dart';

class RootWidgetPage extends StatefulWidget {
  const RootWidgetPage({super.key});

  @override
  State<RootWidgetPage> createState() => _RootWidgetPageState();
}

class _RootWidgetPageState extends State<RootWidgetPage> {
  @override
  void initState() {
    ConnectionChecker.listenForConnectionChanges();
    super.initState();
  }

  @override
  void dispose() {
    ConnectionChecker.cancelConnectionSubscription();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
          scaffoldBackgroundColor: kBlack,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: kTransparent,
            backgroundColor: kBlack,
          )),
      initialRoute: AppRoutesName.introSplash,
      routes: AppRoutes.routes,
    );
  }
}
