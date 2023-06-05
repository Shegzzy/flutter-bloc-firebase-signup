import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/bloc/signup_bloc/signup_event.dart';
import 'package:bloc_firebase/bloc/signup_bloc/signup_state.dart';
import 'package:bloc_firebase/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/validators.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepo _authRepo;

  SignUpBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(SignUpState.initial()) {
    on<SignUpNameChange>(_mapSignUpNameChangeToState);
    on<SignUpEmailChange>(_mapSignUpEmailChangeToState);
    on<SignUpPasswordChange>(_mapSignUpPasswordChangeToState);
    on<SignUpSubmitted>(_mapSignUpSubmittedToState);
  }

  void _mapSignUpNameChangeToState(
      SignUpNameChange event, Emitter<SignUpState> emit) {
    final isNameValid = Validators.isValidName(event.name);
    emit(state.update(isNameValid: isNameValid));
  }

  void _mapSignUpEmailChangeToState(
      SignUpEmailChange event, Emitter<SignUpState> emit) {
    final isEmailValid = Validators.isValidEmail(event.email);
    emit(state.update(isEmailValid: isEmailValid));
  }

  void _mapSignUpPasswordChangeToState(
      SignUpPasswordChange event, Emitter<SignUpState> emit) {
    final isPasswordValid = Validators.isValidPassword(event.password);
    emit(state.update(isPasswordValid: isPasswordValid));
  }

  void _mapSignUpSubmittedToState(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpState.loading());
    try {
      await _authRepo.signUp(
          name: event.name, email: event.email, password: event.password);
      emit(SignUpState.success());
    } catch (_) {
      emit(SignUpState.failure());
    }
  }
}
