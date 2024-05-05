part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {
  final String? token = null;
}

final class UserGettingAuthenticated extends UserState {}

final class UserLoggedIn extends UserState {
  final String token;
  final User user;
  const UserLoggedIn({required this.token, required this.user});
}

final class UserLoginError extends UserState {
  final String message;
  final List<String> errors;
  const UserLoginError({required this.message, required this.errors});
}
