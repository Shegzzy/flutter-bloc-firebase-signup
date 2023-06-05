import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_event_state/auth_bloc.dart';
import '../bloc/bloc_event_state/bloc_event.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            },
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text("Hello, ${user.email}"),
          ),
        ],
      ),
    );
  }
}
