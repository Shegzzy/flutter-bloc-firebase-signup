import 'package:bloc_firebase/bloc/signup_bloc/signup_bloc.dart';
import 'package:bloc_firebase/forms/signup_form.dart';
import 'package:bloc_firebase/widgets/curved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/auth_repo.dart';

class SignUpScreen extends StatelessWidget {

  final AuthRepo _authRepo;

  const SignUpScreen({Key? key, required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(authRepo: _authRepo),
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff2cff0), Color(0xfff4efd0)]

            )
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.white.withOpacity(0.5)]

                      )
                  ),
                  child: const Text('Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                    color: Colors.black54
                  ),
                  ),
                ),
              ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 290),
                    child: SignUpForm(authRepo: _authRepo),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
