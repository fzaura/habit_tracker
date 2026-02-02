import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';
import 'package:habit_tracker/presentation/Auth/bloc/auth_bloc_bloc.dart';

class AuthStateBuilder extends StatelessWidget {
  const AuthStateBuilder({
    super.key,
    required this.state,
    this.successHomeScreenWidget,
    this.failureWidget,
    this.loadingWidget,
    this.initialWidget,
  });

  final AuthBlocState state;
  final Widget Function(AuthUser data)? successHomeScreenWidget;
  final Widget Function(ErrorInterface error)? failureWidget;
  final Widget? loadingWidget;
  final Widget? initialWidget;
  @override
  Widget build(BuildContext context) {
    return switch (state) {
      AuthBlocInitial() => initialWidget ?? const SizedBox.shrink(),
      //The Initial Widget is the Widget that will trigger the event it self 
      //After the Initial Widget is triggered the rest are only the reusults

      AuthBlocLoading() =>
        loadingWidget ?? const Center(child: CircularProgressIndicator()),

      AuthBlocSuccess(user: final data) =>
        successHomeScreenWidget?.call(data) ?? const SizedBox.shrink(),

      AuthBlocFailure(message: final error) => Center(child: Text(error)),

      // Fallback for safety
      _ => const SizedBox.shrink(),
    };
  }
}
