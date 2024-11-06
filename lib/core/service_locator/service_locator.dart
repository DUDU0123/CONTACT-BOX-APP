import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_box/features/auth/data/data_source/auth_data/auth_data.dart';
import 'package:contact_box/features/auth/data/repository/auth_repo/auth_repo_impl.dart';
import 'package:contact_box/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:contact_box/features/auth/domain/usecase/check_user_loggedIn_usecase.dart';
import 'package:contact_box/features/auth/domain/usecase/google_signin_usecase.dart';
import 'package:contact_box/features/auth/domain/usecase/signout_usecase.dart';
import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:contact_box/features/main_entry/presentation/bloc/cubit/page_select_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton(
    () => FirebaseAuth.instance,
  );
  serviceLocator.registerLazySingleton(
    () => FirebaseFirestore.instance,
  );
  initNavDependencies();
  initAuthDependencies();
}

void initNavDependencies() {
  serviceLocator.registerLazySingleton(
    () => PageSelectCubit(),
  );
}

void initAuthDependencies() {
  serviceLocator
    ..registerFactory<AuthData>(
      () => AuthDataImpl(
          firebaseAuth: serviceLocator<FirebaseAuth>(),
          firebaseFirestore: serviceLocator<FirebaseFirestore>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepoImpl(authData: serviceLocator<AuthData>()),
    )
    ..registerFactory(
      () => GoogleSigninUsecase(
        authRepository: serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory(
      () => SignoutUsecase(
        authRepository: serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory(
      () => CheckUserLoggedinUsecase(
        authRepository: serviceLocator<AuthRepository>(),
      ),
    )
    ..registerLazySingleton(
      () => AuthenticationBloc(
        checkUserLoggedinUsecase: serviceLocator<CheckUserLoggedinUsecase>(),
        googleSigninUsecase: serviceLocator<GoogleSigninUsecase>(),
        signoutUsecase: serviceLocator<SignoutUsecase>(),
      ),
    );
}
