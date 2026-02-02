import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DomainLayerInterfaces/loginInterface.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthUser _currentUser = AuthUser(id: '', username: '', email: '');
  LoginInterface _login;

  //Single Truth of usage of the user
  AuthBlocBloc({required LoginInterface login})
    : _login = login,
      super(AuthBlocInitial()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthBlocLoading());
    final result = await _login.execute(
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) {
        emit(AuthBlocFailure(message: failure.errorMessage));
      },
      ((user) {
        _currentUser = user;
        emit(AuthBlocSuccess(user: _currentUser));
      }),
    );
  }
}
