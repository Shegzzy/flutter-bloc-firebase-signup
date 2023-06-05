import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends AuthState{
  @override
  List<Object> get props => [];
}

class AuthInitialize extends AuthState{}

class AuthSuccess extends AuthState{
  final User user;
  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState{}