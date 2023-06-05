class SignUpState {
  final bool isEmailValid;
  final bool isNameValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isNameValid;

  SignUpState({
    this.isPasswordValid = true,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.isEmailValid = true,
    this.isNameValid = true,
  });

  factory SignUpState.initial() {
    return SignUpState();
  }

  factory SignUpState.loading() {
    return SignUpState(
      isSubmitting: true,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isPasswordValid: false,
      isFailure: true,
      isEmailValid: false,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isSuccess: true,
    );
  }

  SignUpState update({
    bool? isPasswordValid,
    bool? isEmailValid,
    bool? isNameValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isNameValid: isNameValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool? isEmailValid,
    bool? isNameValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignUpState(
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isNameValid: isNameValid ?? this.isNameValid,
    );
  }
}
