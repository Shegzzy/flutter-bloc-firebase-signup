import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SignUpNameChange extends SignUpEvent{
  final String name;

  SignUpNameChange({required this.name});

  @override
  List<Object> get props => [name];
}

class SignUpEmailChange extends SignUpEvent{
  final String email;

  SignUpEmailChange({required this.email});

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChange extends SignUpEvent{
  final String password;

  SignUpPasswordChange({required this.password});

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent{
  final String name;
  final String email;
  final String password;

  SignUpSubmitted({required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}