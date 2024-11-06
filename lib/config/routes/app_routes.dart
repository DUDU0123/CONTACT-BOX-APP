import 'package:contact_box/config/routes/app_routes_name.dart';
import 'package:contact_box/features/add_or_edit/presentation/pages/add_contact.dart';
import 'package:contact_box/features/add_or_edit/presentation/pages/edit_contact.dart';
import 'package:contact_box/features/auth/presentation/pages/authentication_page.dart';
import 'package:contact_box/features/main_entry/presentation/pages/main_entry.dart';
import 'package:contact_box/features/splash_intro/splash_intro.dart';
import 'package:contact_box/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:contact_box/features/view_contact/presentation/pages/view_contact.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)>  routes = {
    AppRoutesName.mainEntry : (context) => const MainEntry(),
    AppRoutesName.contactViewPage : (context) => const ViewContact(),
    AppRoutesName.addContact : (context) => const AddContact(),
    AppRoutesName.editContact : (context) => const EditContact(),
    AppRoutesName.introSplash : (context) => const SplashIntro(),
    AppRoutesName.auth : (context) => const AuthenticationPage(),
    AppRoutesName.userProfile : (context) => const UserProfilePage(),
  };
}