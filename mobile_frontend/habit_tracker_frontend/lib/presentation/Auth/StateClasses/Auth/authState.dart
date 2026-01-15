// lib/features/auth/presentation/state/auth_state.dart
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final AuthUser user;
  const AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final ErrorInterface error;
  const AuthFailure(this.error);
}

//unvalid user
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}