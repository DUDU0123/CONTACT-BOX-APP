part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  final bool isUserLoggedIn;
  const AuthenticationSuccessState({
    this.isUserLoggedIn = false,
  });
  @override
  List<Object> get props => [isUserLoggedIn];
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;
  const AuthenticationErrorState({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        message,
      ];
}
