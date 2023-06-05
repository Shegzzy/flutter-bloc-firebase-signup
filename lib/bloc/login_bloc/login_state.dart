// class LoginState{
//   final bool isEmailValid;
//   final bool isPasswordValid;
//   final bool isSubmitting;
//   final bool isSuccess;
//   final bool isFailure;
//
//   bool get isFormValid => isEmailValid && isPasswordValid;
//
//   LoginState(
//       {required this.isPasswordValid,
//       required this.isSubmitting,
//       required this.isSuccess,
//       required this.isFailure,
//       required this.isEmailValid});
//
//   factory LoginState.initial(){
//     return LoginState(
//         isPasswordValid: true,
//         isSubmitting: false,
//         isSuccess: false,
//         isFailure: false,
//         isEmailValid: true,
//     );
//
//   }
//
//   factory LoginState.loading(){
//     return LoginState(
//         isPasswordValid: true,
//         isSubmitting: true,
//         isSuccess: false,
//         isFailure: false,
//         isEmailValid: true,
//     );
//
//   }
//
//   factory LoginState.failure(){
//     return LoginState(
//         isPasswordValid: false,
//         isSubmitting: false,
//         isSuccess: false,
//         isFailure: true,
//         isEmailValid: false,
//     );
//
//   }
//
//   factory LoginState.success(){
//     return LoginState(
//         isPasswordValid: true,
//         isSubmitting: false,
//         isSuccess: true,
//         isFailure: false,
//         isEmailValid: true,
//     );
//
//   }
//
//   LoginState update({
//     required bool isPasswordValid,
//     required bool isEmailValid,
// }){
//     return copyWith(
//         isEmailValid: isEmailValid,
//         isPasswordValid: isPasswordValid,
//         isSubmitting: false,
//         isSuccess: false,
//         isFailure: false);
//   }
//
//   LoginState copyWith({
//     required bool isEmailValid,
//     required bool isPasswordValid,
//     required bool isSubmitting,
//     required bool isSuccess,
//     required bool isFailure,
// }){
//     return LoginState(
//         isPasswordValid: isPasswordValid,
//         isSubmitting: isSubmitting,
//         isSuccess: isSuccess,
//         isFailure: isFailure,
//         isEmailValid: isEmailValid,
//     );
//   }
//
// }

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
