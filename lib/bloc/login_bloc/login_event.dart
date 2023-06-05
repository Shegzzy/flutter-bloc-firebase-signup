import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginEmailChange extends LoginEvent{
  final String email;

  LoginEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChange extends LoginEvent{
  final String password;

  LoginPasswordChange({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCred extends LoginEvent{
  final String email;
  final String password;

  LoginWithCred({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}