import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{
  final _firebaseAuth = FirebaseAuth.instance;

  //SignUp Method
  Future<void>signUp({required String email, required String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    }on
      FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        throw Exception('This password is weak');
    }else if(e.code == 'email-already-in-use'){
        throw Exception('Email taken');
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  //Sign In Method
  Future<void> signIn({required String email, required String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      throw Exception(e.toString());
    }
  }

  //Log Out Method
  Future<void> signOut() async{
    try{
      await Future.wait([_firebaseAuth.signOut()]);
    }catch(e){
      throw Exception(e.toString());
    }
  }

  //Current User
  Future<bool> isSignedIn() async{
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  //Get Current User
  Future<User?> getUser() async{
    return _firebaseAuth.currentUser;
  }
}
