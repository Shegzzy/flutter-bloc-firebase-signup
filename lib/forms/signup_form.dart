import 'package:bloc_firebase/bloc/signup_bloc/signup_event.dart';
import 'package:bloc_firebase/bloc/signup_bloc/signup_state.dart';
import 'package:bloc_firebase/screens/login_screen.dart';
import 'package:bloc_firebase/widgets/form-widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_event_state/auth_bloc.dart';
import '../bloc/bloc_event_state/bloc_event.dart';
import '../bloc/signup_bloc/signup_bloc.dart';
import '../data/repo/auth_repo.dart';

class SignUpForm extends StatefulWidget {

  final AuthRepo authRepo;
  const SignUpForm({Key? key, required this.authRepo}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
 final TextEditingController _nameController = TextEditingController();
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();

 bool get isPopulated =>
     _nameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

 bool isButtonEnabled(SignUpState state) {
   return state.isFormValid && isPopulated && !state.isSubmitting;
 }

 late SignUpBloc _signUpBloc;

 @override
 void initState() {
   super.initState();
   _signUpBloc = BlocProvider.of<SignUpBloc>(context);
   _nameController.addListener(_onNameChange);
   _emailController.addListener(_onEmailChange);
   _passwordController.addListener(_onPasswordChange);
 }


 @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sign Up Failed'),
                    Icon(Icons.error),
                  ],
                ),
              ),
              backgroundColor: Color(0xffffae88),
            ),
          );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Signing Up...'),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
              backgroundColor: Color(0xffffae88),
            ),
          );
        }

        if (state.isSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Signed In'),
                  Icon(Icons.check_circle_rounded, color: Colors.cyanAccent)
                ],
              ),
              backgroundColor: Color(0xffffae88),
            ),
          );
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
            
          );
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Full Name",
                    autoCorrect: false,
                    validator: (_) {
                      return !state.isNameValid ? 'Invalid Name' : null;
                    },
                    controller: _nameController,
                    iconData: const Icon(Icons.email_sharp, color: Colors.lightBlue,),
                    keyboardType: TextInputType.emailAddress,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  const SizedBox(height: 30,),
                  CustomTextField(
                    labelText: "Email",
                    autoCorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email Address' : null;
                    },
                    controller: _emailController,
                    iconData: const Icon(Icons.email_sharp, color: Colors.lightBlue,),
                    keyboardType: TextInputType.emailAddress,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  const SizedBox(height: 30,),
                  CustomTextField(
                    labelText: "Password",
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                    controller: _passwordController,
                    iconData: const Icon(Icons.password_sharp, color: Colors.lightBlue,),
                    obscureText: true,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),

                  const SizedBox(height: 40),
                  CustomButton(
                      width: 200,
                      text: 'Sign Up',
                      onPressed: () {
                        if (isButtonEnabled(state)) {
                          _onFormSubmitted();
                        }
                      },
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                  ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                        text: "Already have an account?",
                        style: const TextStyle(color: Colors.black45),
                        children: [
                          TextSpan(
                              text: " Login",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                })
                        ]),
                  )

                ],
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 void _onNameChange() {
   _signUpBloc.add(SignUpNameChange(name: _nameController.text));
 }

 void _onEmailChange() {
   _signUpBloc.add(SignUpEmailChange(email: _emailController.text));
 }

 void _onPasswordChange() {
   _signUpBloc.add(SignUpPasswordChange(password: _passwordController.text));
 }

 void _onFormSubmitted() {
   _signUpBloc.add(SignUpSubmitted(
     name: _nameController.text,
     email: _emailController.text,
     password: _passwordController.text,
   ));
 }

}
