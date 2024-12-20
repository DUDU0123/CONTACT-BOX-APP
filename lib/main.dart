import 'package:contact_box/core/service_locator/service_locator.dart';
import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contact_box/features/favourite/presentation/bloc/bloc/favorite_bloc.dart';
import 'package:contact_box/features/main_entry/presentation/bloc/cubit/page_select_cubit.dart';
import 'package:contact_box/features/root_widget_page.dart';
import 'package:contact_box/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<PageSelectCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ContactBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<FavoriteBloc>(),
        ),
      ],
      child: const RootWidgetPage(),
    ),
  );
}
