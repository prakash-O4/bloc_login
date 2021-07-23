import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/blocs/Login/login_bloc.dart';
import 'package:logss/constants/style.dart';
import 'package:logss/blocs/cubit/navigation_cubit.dart';

import '../../FormSubmissionStatus.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({Key? key}) : super(key: key);

  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  final _finalLoginKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _finalLoginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: StyleConstants.kCompanyLogo,
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleConstants.kAuthText("LOG IN NOW"),
              const SizedBox(height: 12),
              StyleConstants.kAuthDetails(
                "Please fill the details and proceed further",
              ),
              const SizedBox(
                height: 16,
              ),
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(),
              const SizedBox(height: 20),
              _logIn(),
              const SizedBox(height: 20),
              _goToSignUp(),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          cursorColor: Colors.pink,
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.kInput("Enter email address"),
          onChanged: (value) => _loginBloc.add(LogInEmailChanged(email: value)),
          validator: (value) =>
              state.isValidEmail ? null : "Enter correct email",
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          textInputAction: TextInputAction.done,
          cursorColor: Colors.pink,
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.kInput("Enter your password"),
          onChanged: (value) =>
              _loginBloc.add(LogInPasswordChanged(password: value)),
          validator: (value) => state.isValidPassword ? null : "Greater than 6",
        );
      },
    );
  }

  Widget _logIn() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        var _status = state.status;
        if (_status is FormSubmitting) {
          return StyleConstants.kLoadingButton();
        }
        return ElevatedButton(
            style: StyleConstants.kButtonStyle,
            onPressed: () {
              if (_finalLoginKey.currentState!.validate()) {
                _loginBloc.add(LogInSubmitted());
              }
            },
            child: StyleConstants.kButtonText("LOG IN"));
      },
    );
  }

  Widget _goToSignUp() {
    return TextButton(
        onPressed: () {
          BlocProvider.of<NavigationCubit>(context).showSignUp();
        },
        child: const Center(
          child: Text("Go to Sign Up"),
        ));
  }

  // ignore: unused_element
  _errorDialog(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    )));
  }
}
