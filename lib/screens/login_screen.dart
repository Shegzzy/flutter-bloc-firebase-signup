import 'package:bloc_firebase/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_firebase/data/repo/auth_repo.dart';
import 'package:bloc_firebase/forms/login_form.dart';
import 'package:bloc_firebase/forms/signup_form.dart';
import 'package:bloc_firebase/widgets/curved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {

  final AuthRepo authRepo;
  const LoginScreen({super.key, required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authRepo: authRepo),
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
                    child: const Text('Login',
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
                    margin: const EdgeInsets.only(top: 290),
                    child: LoginForm(authRepo: authRepo),
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
