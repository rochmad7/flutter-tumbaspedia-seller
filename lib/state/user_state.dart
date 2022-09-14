part of '../cubit/user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

// class UserLoaded extends UserState {
//   final User user;

//   UserLoaded(this.user);

//   @override
//   List<Object> get props => [user];
// }

class UserLoaded extends UserState {
  final User user;
  final String token;

  UserLoaded(this.user, this.token);

  @override
  List<Object> get props => [user];
}

class UserLoadedWithShop extends UserState {
  final User user;
  final Shop shop;
  final String token;

  UserLoadedWithShop(this.user, this.shop, this.token);

  @override
  List<Object> get props => [user, shop];
}

class UserLoadingFailed extends UserState {
  final String message;
  final Map<String, dynamic> error;

  UserLoadingFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class UserForgotPassword extends UserState {
  final String email;
  final String message;

  UserForgotPassword(this.message, this.email);

  @override
  List<Object> get props => [message, email];
}

class UserForgotPasswordFailed extends UserState {
  final String message;
  final Map<String, dynamic> error;

  UserForgotPasswordFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class UserEdited extends UserState {
  final User user;
  // final String message;

  UserEdited(this.user);

  @override
  List<Object> get props => [user];
}

class UserEditedFailed extends UserState {
  final String message;
  final Map<String, dynamic> error;

  UserEditedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}
