import 'package:flutter_riverpod/legacy.dart';
import 'package:habit_tracker/core/Config/providers.dart';
import 'package:habit_tracker/domain/Auth/Features/loginUseCase.dart';
import 'package:habit_tracker/domain/Auth/Features/logoutUseCase.dart';
import 'package:habit_tracker/domain/Auth/Features/registerUseCase.dart';
import 'package:habit_tracker/presentation/Auth/bloc/auth_bloc_bloc.dart';



class AuthNotifier extends StateNotifier<AuthBlocState> {
  // We assume you have a repository passed in
  final RegisterUseCase _authUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  String tempErrorMessage1 = '';
  String tempErrorMessage2 = '';
  AuthNotifier(this._authUseCase, this._loginUseCase , this._logoutUseCase)
    : super( AuthBlocInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // 1. Immediately tell the UI to show a loading spinner
    state =  AuthBlocLoading();

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
          state = AuthBlocFailure(message:  wrongObject.errorMessage);
          print(
            'Error from auth provider : ${wrongObject.errorMessage} and ${wrongObject.stackTrace} ',
          );
          tempErrorMessage1 = wrongObject.errorMessage;
          tempErrorMessage2 = wrongObject.stackTrace.toString();
        },
        (trueObject) {
          state = AuthBlocSuccess(user:  trueObject);
        },
      );
    } catch (e) {
      // 4. If it fails, update state with the error message
      print(
        'Wrong huge FAIILL Suth Provider btw speaking ${tempErrorMessage1} and btw we have this $tempErrorMessage2 okay $e',
      );
    }
  }

  Future<void> login({required String email, required String password}) async {
    state =  AuthBlocLoading();
    try {
      final loginUser = await _loginUseCase.execute(
        email: email,
        password: password,
      );
      loginUser.fold(
        (wrongObject) {
          state = AuthBlocFailure(message:  wrongObject.errorMessage);
          print(
            'Error from auth provider : ${wrongObject.errorMessage} and ${wrongObject.stackTrace} ',
          );
          tempErrorMessage1 = wrongObject.errorMessage;
          tempErrorMessage2 = wrongObject.stackTrace.toString();
        },
        (rightObject) {
          state = AuthBlocSuccess(user:  rightObject);
        },
      );
    } catch (e) {
      print(
        'Wrong huge FAIILL Suth Provider btw speaking ${tempErrorMessage1} and btw we have this $tempErrorMessage2 okay $e',
      );
    }
  }

/// THE LOGOUT METHOD
  Future<void> handleLogout() async {
    // Piece A: Trigger the Use Case (Domain Logic)
    await _logoutUseCase.execute();
    
    // Piece B: Update the State (UI Logic)
    // This tells the whole app: "There is no longer a user here."
    state =  AuthBlocUnauthenticated(); 
  }
}
// 1. First type: The Class (AuthNotifier)
// 2. Second type: The State (AuthState - the Sealed Class)
final authProvider = StateNotifierProvider<AuthNotifier, AuthBlocState>((ref) {
  // Get your repository/usecase from your core providers
  final regUsecase = ref.watch(registerFeatureProvider);
  final logUsecase = ref.watch(loginFeatureProvider);
  final logOutUsecase=ref.watch(logoutFeatureProvider);
  // Return the initialized Notifier
  return AuthNotifier(regUsecase, logUsecase,logOutUsecase);
});
