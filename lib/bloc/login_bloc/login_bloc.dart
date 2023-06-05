import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/bloc/login_bloc/login_event.dart';
import 'package:bloc_firebase/bloc/login_bloc/login_state.dart';
import 'package:bloc_firebase/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  LoginBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(LoginState.initial()) {
    on<LoginEmailChange>(_mapLoginEmailChangeToState);
    on<LoginPasswordChange>(_mapSignUpPasswordChangeToState);
    on<LoginWithCred>(_mapLoginWithCredToState);
  }

  void _mapLoginEmailChangeToState(
      LoginEmailChange event, Emitter<LoginState> emit) {
    final isEmailValid = Validators.isValidEmail(event.email);
    emit(state.update(isEmailValid: isEmailValid));
  }

  void _mapSignUpPasswordChangeToState(
      LoginPasswordChange event, Emitter<LoginState> emit) {
    final isPasswordValid = Validators.isValidPassword(event.password);
    emit(state.update(isPasswordValid: isPasswordValid));
  }

  void _mapLoginWithCredToState(
      LoginWithCred event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      await _authRepo.signIn(email: event.email, password: event.password);
      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }
}
