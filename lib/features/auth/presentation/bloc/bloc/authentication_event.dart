part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


class CheckUserLoggedInEvent extends AuthenticationEvent{}
class SignOutUserEvent extends AuthenticationEvent{}
class SignInUserEvent extends AuthenticationEvent{}