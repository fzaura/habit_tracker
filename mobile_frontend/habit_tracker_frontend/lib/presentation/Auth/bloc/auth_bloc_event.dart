part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

  final class LoginEvent extends AuthBlocEvent {
    final String email;
    final String password;

    LoginEvent({
      required this.email,
      required this.password,
    });

    @override
    List<Object?> get props => [email, password];
  }

  final class RegisterEvent extends AuthBlocEvent {
    final String username;
    final String email;
    final String password;
    final String confirmPassword;

    RegisterEvent({
      required this.username,
      required this.email,
      required this.password,
      required this.confirmPassword,
    });

    @override
    List<Object?> get props => [username, email, password, confirmPassword];
  }

  final class LogoutEvent extends AuthBlocEvent {}

  final class CheckAuthStatusEvent extends AuthBlocEvent {}