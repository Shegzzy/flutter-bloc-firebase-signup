import 'package:bloc_firebase/screens/home_screen.dart';
import 'package:bloc_firebase/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_event_state/auth_bloc.dart';
import 'bloc/bloc_event_state/bloc_event.dart';
import 'bloc/bloc_event_state/bloc_state.dart';
import 'data/repo/auth_repo.dart';
import 'observer.dart';

void main() async{
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final AuthRepo authRepo = AuthRepo();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(
        authRepo: authRepo,
      )..add(AuthStarted()),
      child: MyApp(
        authRepo: authRepo,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepo _authRepo;

  MyApp({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailure) {
            return SignUpScreen(authRepo: _authRepo,);
          }

          if (state is AuthSuccess) {
            return HomeScreen(
              user: state.user,
            );
          }

          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(child: Text("Loading")),
            ),
          );
        },
      ),
    );
  }
}