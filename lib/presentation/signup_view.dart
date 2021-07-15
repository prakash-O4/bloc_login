import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/FormSubmissionStatus.dart';
import 'package:logss/blocs/SignUp/signup_bloc.dart';
import 'package:logss/constants/color.dart';
import 'package:logss/constants/style.dart';
import 'package:logss/cubit/navigation_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _finalSignUpKey = GlobalKey<FormState>();
  late SignupBloc _signupBloc;
  @override
  void initState() {
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _signupBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstants.kBackgroundColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 18,
              top: 20,
            ),
            child: Form(
              key: _finalSignUpKey,
              child: Column(
                children: [
                  StyleConstants.kCompanyLogo,
                  SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyleConstants.kAuthText("SIGN UP NOW"),
                      SizedBox(height: 4),
                      StyleConstants.kAuthDetails(
                          "Please fill the details and create account"),
                      SizedBox(
                        height: 8,
                      ),
                      _userNameField(),
                      SizedBox(height: 14),
                      _signUpEmail(),
                      SizedBox(height: 14),
                      _signUpPassword(),
                      SizedBox(height: 14),
                      _signUpConfPassword(),
                      SizedBox(height: 14),
                      _signUpButton(),
                      SizedBox(height: 14),
                      _goToLogIn(),
                      SizedBox(height: 14),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpEmail() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.input("Enter email address"),
          onChanged: (value) =>
              _signupBloc.add(SignUpEmailChanged(email: value)),
          validator: (value) => state.isValidEmail ? null : "Enter valid email",
        );
      },
    );
  }

  Widget _signUpPassword() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.input("Enter password"),
          onChanged: (value) =>
              _signupBloc.add(SignUpPasswordChanged(password: value)),
          validator: (value) =>
              state.isValidPassword ? null : "Strong password",
        );
      },
    );
  }

  Widget _signUpConfPassword() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.input("Confirm Password"),
          onChanged: (value) =>
              _signupBloc.add(SignUpConfPassChanged(confPassword: value)),
          validator: (value) =>
              state.matchPassword ? null : "Password not matching",
        );
      },
    );
  }

  Widget _userNameField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          style: StyleConstants.kTextStyle,
          cursorColor: Colors.pink,
          decoration: StyleConstants.input("Enter username"),
          onChanged: (value) =>
              _signupBloc.add(SignUpNameChanged(userName: value)),
          validator: (value) => state.isValidateUserName ? null : "More than 3",
        );
      },
    );
  }

  Widget _signUpButton() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        var _status = state.status;
        if (state.status is FormSubmitting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(ColorConstants.kButtonColor),
            ),
          );
        } else if (_status is SubmissionFailed) {
          return Center(
            child: Text(
              _status.exception,
              style: TextStyle(
                fontSize: 20,
                color: Colors.pink,
              ),
            ),
          );
        }
        return ElevatedButton(
            style: StyleConstants.kButtonStyle,
            onPressed: () {
              if (_finalSignUpKey.currentState!.validate()) {
                _signupBloc.add(SignUpSubmitted());
              }
            },
            child: StyleConstants.kButtonText("Sign Up"));
      },
    );
  }

  Widget _goToLogIn() {
    return TextButton(
        onPressed: () {
          BlocProvider.of<NavigationCubit>(context).showLogIn();
        },
        child: Center(
          child: Text("Go to Sign Up"),
        ));
  }
}
