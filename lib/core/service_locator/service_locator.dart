import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_box/features/auth/data/data_source/auth_data/auth_data.dart';
import 'package:contact_box/features/auth/data/repository/auth_repo/auth_repo_impl.dart';
import 'package:contact_box/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:contact_box/features/auth/domain/usecase/check_user_loggedIn_usecase.dart';
import 'package:contact_box/features/auth/domain/usecase/google_signin_usecase.dart';
import 'package:contact_box/features/auth/domain/usecase/signout_usecase.dart';
import 'package:contact_box/features/auth/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:contact_box/features/contacts/data/data_sources/cache_contact_data.dart';
import 'package:contact_box/features/contacts/data/data_sources/contact_data.dart';
import 'package:contact_box/features/contacts/data/repository/cache_contact_repo/cache_contact_repo_impl.dart';
import 'package:contact_box/features/contacts/data/repository/contact_repo/contact_repository_impl.dart';
import 'package:contact_box/features/contacts/domain/repository/cache_contact_repo/cache_contact_repo.dart';
import 'package:contact_box/features/contacts/domain/repository/contact_repo/contact_repository.dart';
import 'package:contact_box/features/contacts/domain/usecase/add_contact_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/delete_contact_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/edit_contact_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/get_all_contacts_usecase.dart';
import 'package:contact_box/features/contacts/domain/usecase/get_cache_contact_data.dart';
import 'package:contact_box/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contact_box/features/favourite/data/fav_data/favorite_data.dart';
import 'package:contact_box/features/favourite/data/fav_repo/favorite_repository_impl.dart';
import 'package:contact_box/features/favourite/domain/repository/favorite_repository.dart';
import 'package:contact_box/features/favourite/domain/usecase/add_to_favorite_usecase.dart';
import 'package:contact_box/features/favourite/domain/usecase/get_all_favorites_usecase.dart';
import 'package:contact_box/features/favourite/domain/usecase/remove_one_favorite_usecase.dart';
import 'package:contact_box/features/favourite/presentation/bloc/bloc/favorite_bloc.dart';
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
  initContactDependencies();
  initFavoriteDependencies();
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

initContactDependencies() {
  serviceLocator
    ..registerFactory<CacheContactData>(
      () => CacheContactDataImpl(),
    )
    ..registerFactory<CacheContactRepo>(
      () => CacheContactRepoImpl(
        cacheContactData: serviceLocator<CacheContactData>(),
      ),
    )
    ..registerFactory(
      () => GetCacheContactDataUseCase(
        cacheContactRepo: serviceLocator<CacheContactRepo>(),
      ),
    )
    ..registerFactory<ContactData>(
      () => ContactDataImpl(
          cacheContactData: serviceLocator<CacheContactData>(),
          firebaseFirestore: serviceLocator<FirebaseFirestore>()),
    )
    ..registerFactory<ContactRepository>(
      () => ContactRepositoryImpl(contactData: serviceLocator<ContactData>()),
    )
    ..registerFactory(
      () => GetAllContactsUsecase(
        contactRepository: serviceLocator<ContactRepository>(),
      ),
    )
    ..registerFactory(
      () => AddContactUsecase(
        contactRepository: serviceLocator<ContactRepository>(),
      ),
    )
    ..registerFactory(
      () => EditContactUsecase(
        contactRepository: serviceLocator<ContactRepository>(),
      ),
    )
    ..registerFactory(
      () => DeleteContactUsecase(
        contactRepository: serviceLocator<ContactRepository>(),
      ),
    )
    ..registerLazySingleton(
      () => ContactBloc(
        getCacheContactDataUseCase:
            serviceLocator<GetCacheContactDataUseCase>(),
        getAllContactsUsecase: serviceLocator<GetAllContactsUsecase>(),
        addContactUsecase: serviceLocator<AddContactUsecase>(),
        editContactUsecase: serviceLocator<EditContactUsecase>(),
        deleteContactUsecase: serviceLocator<DeleteContactUsecase>(),
      ),
    );
}

initFavoriteDependencies() {
  serviceLocator
    ..registerFactory<FavoriteData>(
      () => FavoriteDataImpl(
          firebaseFirestore: serviceLocator<FirebaseFirestore>()),
    )
    ..registerFactory<FavoriteRepository>(
      () =>
          FavoriteRepositoryImpl(favoriteData: serviceLocator<FavoriteData>()),
    )
    ..registerFactory(
      () => GetAllFavoritesUsecase(
        favoriteRepository: serviceLocator<FavoriteRepository>(),
      ),
    )
    ..registerFactory(
      () => AddToFavoriteUsecase(
        favoriteRepository: serviceLocator<FavoriteRepository>(),
      ),
    )
    ..registerFactory(
      () => RemoveOneFavoriteUsecase(
        favoriteRepository: serviceLocator<FavoriteRepository>(),
      ),
    )
    ..registerLazySingleton(
      () => FavoriteBloc(
        getAllFavoritesUsecase: serviceLocator<GetAllFavoritesUsecase>(),
        addToFavoriteUsecase: serviceLocator<AddToFavoriteUsecase>(),
        removeOneFavoriteUsecase: serviceLocator<RemoveOneFavoriteUsecase>(),
      ),
    );
}
