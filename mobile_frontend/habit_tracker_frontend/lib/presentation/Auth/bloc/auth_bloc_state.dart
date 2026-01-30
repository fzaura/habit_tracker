part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthBlocLoading extends AuthBlocState {}

final class AuthBlocSuccess extends AuthBlocState {
  final AuthUser user;

  AuthBlocSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthBlocFailure extends AuthBlocState {
  final String message;

  AuthBlocFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

final class AuthBlocUnauthenticated extends AuthBlocState {}
