part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserInitialEvent extends UserEvent {}

class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  const UserLoginEvent({required this.email, required this.password});
}

class UserSignupEvent extends UserEvent {
  final String email;
  final String password;
  final String fullName;

  const UserSignupEvent(
      {required this.email, required this.password, required this.fullName});
}

class UserAuthErrorEvent extends UserEvent {
  final String message;

  const UserAuthErrorEvent({required this.message});
}

class UserLogoutEvent extends UserEvent {}

class CheckUserIsAuthenticated extends UserEvent {}
