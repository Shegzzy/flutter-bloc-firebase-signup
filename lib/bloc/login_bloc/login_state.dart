class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    this.isPasswordValid = true,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.isEmailValid = true,
  });

  factory LoginState.initial() {
    return LoginState();
  }

  factory LoginState.loading() {
    return LoginState(
      isSubmitting: true,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isPasswordValid: false,
      isFailure: true,
      isEmailValid: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSuccess: true,
    );
  }

  LoginState update({
    bool? isPasswordValid,
    bool? isEmailValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isEmailValid: isEmailValid ?? this.isEmailValid,
    );
  }
}
