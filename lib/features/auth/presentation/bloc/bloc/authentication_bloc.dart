import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contact_box/features/auth/domain/usecase/check_user_loggedIn_usecase.dart';
import 'package:contact_box/features/auth/domain/usecase/google_signin_usecase.dart';
import 'package:contact_box/features/auth/domain/usecase/signout_usecase.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final CheckUserLoggedinUsecase _checkUserLoggedinUsecase;
//   final SignoutUsecase _signoutUsecase;
//   final GoogleSigninUsecase _googleSigninUsecase;
//   AuthenticationBloc({
//     required CheckUserLoggedinUsecase checkUserLoggedinUsecase,
//     required SignoutUsecase signoutUsecase,
//     required GoogleSigninUsecase googleSigninUsecase,
//   })  : _checkUserLoggedinUsecase = checkUserLoggedinUsecase,
//         _googleSigninUsecase = googleSigninUsecase,
//         _signoutUsecase = signoutUsecase,
//         super(AuthenticationInitial()) {
//     on<CheckUserLoggedInEvent>(checkUserLoggedInEvent);
//     on<SignOutUserEvent>(signOutUserEvent);
//     on<SignInUserEvent>(signInUserEvent);
//   }

//   FutureOr<void> checkUserLoggedInEvent(
//       CheckUserLoggedInEvent event, Emitter<AuthenticationState> emit) async {
//     try {
//       final res = await _checkUserLoggedinUsecase(params: null);
//       res.fold(
//         (failure) {
//           emit(AuthenticationErrorState(message: failure.message));
//         },
//         (isLoggedIn) {
//           emit(AuthenticationSuccessState(isUserLoggedIn: isLoggedIn));
//         },
//       );
//     } catch (e) {
//       emit(AuthenticationErrorState(message: e.toString()));
//     }
//   }

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CheckUserLoggedinUsecase _checkUserLoggedinUsecase;
  final SignoutUsecase _signoutUsecase;
  final GoogleSigninUsecase _googleSigninUsecase;

  AuthenticationBloc({
    required CheckUserLoggedinUsecase checkUserLoggedinUsecase,
    required SignoutUsecase signoutUsecase,
    required GoogleSigninUsecase googleSigninUsecase,
  })  : _checkUserLoggedinUsecase = checkUserLoggedinUsecase,
        _googleSigninUsecase = googleSigninUsecase,
        _signoutUsecase = signoutUsecase,
        super(AuthenticationInitial()) {
    on<CheckUserLoggedInEvent>(checkUserLoggedInEvent);
    on<SignOutUserEvent>(signOutUserEvent);
    on<SignInUserEvent>(signInUserEvent);
  }

  FutureOr<void> checkUserLoggedInEvent(
      CheckUserLoggedInEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final res = await _checkUserLoggedinUsecase(params: null);
      res.fold(
        (failure) {
          emit(AuthenticationErrorState(message: failure.message));
        },
        (isLoggedIn) {
          emit(AuthenticationSuccessState(isUserLoggedIn: isLoggedIn));
        },
      );
    } catch (e) {
      emit(AuthenticationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> signOutUserEvent(
      SignOutUserEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final res = await _signoutUsecase(params: null);
      res.fold(
        (failure) {
          emit(AuthenticationErrorState(message: failure.message));
        },
        (isSignedOut) {
          // Set isUserLoggedIn to false explicitly after sign-out
          emit(AuthenticationSuccessState(isUserLoggedIn: false));
        },
      );
    } catch (e) {
      emit(AuthenticationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> signInUserEvent(
      SignInUserEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final res = await _googleSigninUsecase(params: null);
      res.fold(
        (failure) {
          emit(AuthenticationErrorState(message: failure.message));
        },
        (result) {
          // Set isUserLoggedIn to true explicitly after sign-in
          emit(AuthenticationSuccessState(isUserLoggedIn: true));
        },
      );
    } catch (e) {
      emit(AuthenticationErrorState(message: e.toString()));
    }
  }
}
//   FutureOr<void> signOutUserEvent(
//       SignOutUserEvent event, Emitter<AuthenticationState> emit) async {
//     try {
//       final res = await _signoutUsecase(params: null);
//       res.fold(
//         (failure) {
//           emit(AuthenticationErrorState(message: failure.message));
//         },
//         (isSignedOut) {
//           emit(AuthenticationSuccessState(isUserLoggedIn: isSignedOut?false:true));
//         },
//       );
//     } catch (e) {
//       emit(AuthenticationErrorState(message: e.toString()));
//     }
//   }

//   FutureOr<void> signInUserEvent(
//       SignInUserEvent event, Emitter<AuthenticationState> emit) async {
//     try {
//       final res = await _googleSigninUsecase(params: null);
//       res.fold(
//         (failure) {
//           emit(AuthenticationErrorState(message: failure.message));
//         },
//         (result) {
//           emit(AuthenticationSuccessState());
//         },
//       );
//     } catch (e) {
//       emit(AuthenticationErrorState(message: e.toString()));
//     }
//   }
// }
