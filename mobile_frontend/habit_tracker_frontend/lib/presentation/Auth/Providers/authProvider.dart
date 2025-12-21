import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/core/Config/providers.dart';
import 'package:habit_tracker/domain/Auth/Features/registerUseCase.dart';
import 'package:habit_tracker/presentation/Auth/State/authState.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  // We assume you have a repository passed in
  final RegisterUseCase _authUseCase;
  String tempErrorMessage1='';
  String tempErrorMessage2='';
  AuthNotifier(this._authUseCase) : super(const AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // 1. Immediately tell the UI to show a loading spinner
    state = const AuthLoading();

    try {
      // 2. Call your actual backend/API logic
      final user = await _authUseCase.execute(
        username: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      // 3. If successful, update state with the user data
      user.fold(
        (wrongObject) {
          state = AuthFailure(wrongObject);
          print('Error from auth provider : ${wrongObject.errorMessage} and ${wrongObject.stackTrace} ');
          tempErrorMessage1=wrongObject.errorMessage;
          tempErrorMessage2=wrongObject.stackTrace.toString();

        },
        (trueObject) {
          state = AuthSuccess(trueObject);
        },
      );
    } catch (e) {
      // 4. If it fails, update state with the error message
      print('Wrong huge FAIILL Suth Provider btw speaking ${tempErrorMessage1} and btw we have this $tempErrorMessage2 okay $e');
    }
  }
}

// 1. First type: The Class (AuthNotifier)
// 2. Second type: The State (AuthState - the Sealed Class)
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // Get your repository/usecase from your core providers
  final usecase = ref.watch(registerFeatureProvider);

  // Return the initialized Notifier
  return AuthNotifier(usecase);
});
