import 'package:bloc_firebase/data/repo/auth_repo.dart';
import 'package:bloc_firebase/screens/signup_screen.dart';
import 'package:bloc_firebase/widgets/form-widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_event_state/auth_bloc.dart';
import '../bloc/bloc_event_state/bloc_event.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/login_bloc/login_state.dart';

class LoginForm extends StatefulWidget {

  final AuthRepo authRepo;

  const LoginForm({Key? key, required this.authRepo}) : super(key: key);


  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Login Failed'),
                  Icon(Icons.error),
                ],
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
                children: [
                  Text('Logging In...'),
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
          BlocProvider.of<AuthBloc>(context).add(
            AuthLoggedIn(),
          );
        }
      },
      
      child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                      labelText: "Email",
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
                      text: 'Login',
                      onPressed: (){
                        if (isButtonEnabled(state)) {
                          _onFormSubmitted();
                        }
                      },
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(color: Colors.black45),
                          children: [
                            TextSpan(
                                text: " SignUp",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen(authRepo: widget.authRepo)
                                      ),
                                    );
                                  })
                          ]),
                    )

                  ],
                ),
              ),
            );
          },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChange(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCred(
        email: _emailController.text, password: _passwordController.text));
  }
}
