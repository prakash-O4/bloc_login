import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logss/blocs/SignUp/signup_bloc.dart';
import 'package:logss/blocs/cubit/navigation_cubit.dart';
import 'package:logss/constants/color.dart';
import 'package:logss/constants/style.dart';

import '../../FormSubmissionStatus.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _finalSignUpKey = GlobalKey<FormState>();
  late SignupBloc _signupBloc;
  @override
  void initState() {
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
  }

  @override
  void dispose() {
    _signupBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _finalSignUpKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: StyleConstants.kCompanyLogo,
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleConstants.kAuthText("SIGN UP NOW"),
              const SizedBox(height: 12),
              StyleConstants.kAuthDetails(
                  "Please fill the details and create account"),
              const SizedBox(
                height: 16,
              ),
              _userNameField(),
              const SizedBox(height: 20),
              _signUpEmail(),
              const SizedBox(height: 20),
              _signUpPassword(),
              const SizedBox(height: 20),
              _signUpConfPassword(),
              const SizedBox(height: 20),
              _signUpButton(),
              const SizedBox(height: 20),
              _goToLogIn(),
              const SizedBox(height: 20),
              _socialIcon()
            ],
          ),
        ],
      ),
    );
  }

  Widget _signUpEmail() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          cursorColor: Colors.pink,
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.kInput("Enter email address"),
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
          textInputAction: TextInputAction.next,
          cursorColor: Colors.pink,
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.kInput("Enter password"),
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
          textInputAction: TextInputAction.done,
          cursorColor: Colors.pink,
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.kInput("Confirm Password"),
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
          textInputAction: TextInputAction.next,
          cursorColor: Colors.pink,
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.kInput("Enter username"),
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
        if (_status is FormSubmitting) {
          return StyleConstants.kLoadingButton();
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
        child: const Center(
          child: Text("Go to Log In"),
        ));
  }

  Widget _socialIcon() {
    return CircleAvatar(
        backgroundColor: const Color(
          ColorConstants.kBackgroundColor,
        ),
        radius: 20,
        child: IconButton(
          onPressed: () {
            _signupBloc.add(GoogleSignedIn());
          },
          icon: const Icon(
            FontAwesomeIcons.google,
            size: 20,
          ),
        ));
  }
}
