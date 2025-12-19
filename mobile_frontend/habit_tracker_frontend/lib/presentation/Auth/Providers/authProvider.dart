import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/presentation/Auth/State/authState.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  // We assume you have a repository passed in
  final dynamic _authUseCase; 

  AuthNotifier(this._authUseCase) : super(const AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Immediately tell the UI to show a loading spinner
    state = const AuthLoading();

    try {
      // 2. Call your actual backend/API logic
      final user = await _authUseCase.signUp(
        name: name,
        email: email,
        password: password,
      );

      // 3. If successful, update state with the user data
      state = AuthSuccess(user);
      
    } catch (e) {
      // 4. If it fails, update state with the error message
      state = AuthFailure(e.toString());
    }
  }
}
// 1. First type: The Class (AuthNotifier)
// 2. Second type: The State (AuthState - the Sealed Class)
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  
  // Get your repository/usecase from your core providers
  final repository = ref.watch(authRepositoryProvider);
  
  // Return the initialized Notifier
  return AuthNotifier(repository); 
});