part of 'authcubit_cubit.dart';

abstract class AuthcubitState extends Equatable {
  const AuthcubitState();

  @override
  List<Object> get props => [];
}

class AuthcubitInitial extends AuthcubitState {}

class AuthcubitLoading extends AuthcubitState {}

class AuthcubitLoginError extends AuthcubitState {
  final String message;
  AuthcubitLoginError(this.message);
  @override
  List<Object> get props => [message];
}

class ProvinesLoaded extends AuthcubitState {
  final ProvinesModel provines;
  ProvinesLoaded(this.provines);
  @override
  List<Object> get props => [provines];
}

class ProfileLoaded extends AuthcubitState {
  final ProfileModelRes profile;
  ProfileLoaded(this.profile);
  @override
  List<Object> get props => [profile];
}

class AuthcubitProfileLoaded extends AuthcubitState {
  final ProfileModelRes profile;
  AuthcubitProfileLoaded(this.profile);
  @override
  List<Object> get props => [profile];
}

class AuthcubitLoginNetworkError extends AuthcubitState {}
