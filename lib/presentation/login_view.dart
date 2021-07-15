import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/FormSubmissionStatus.dart';
import 'package:logss/blocs/Login/login_bloc.dart';
import 'package:logss/constants/color.dart';
import 'package:logss/constants/style.dart';
import 'package:logss/cubit/navigation_cubit.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _finalLoginKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstants.kBackgroundColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 18, right: 18),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                var _status = state.status;
                if (_status is SubmissionFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _status.exception,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              //only shows snack bar when there is unique state when state repeats 
              //the it will returns false and listener will not be called. 
              listenWhen: (prevoius, current) {
                var _previous = prevoius.status;
                var _current = current.status;
                if (_previous != _current) {
                  print("listen when");
                  return true;
                }
                return false;
              },
              child: Form(
                key: _finalLoginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StyleConstants.kCompanyLogo,
                    SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleConstants.kAuthText("LOG IN NOW"),
                        SizedBox(height: 4),
                        StyleConstants.kAuthDetails(
                            "Please fill the details and proceed further"),
                        SizedBox(
                          height: 8,
                        ),
                        _emailField(),
                        SizedBox(height: 14),
                        _passwordField(),
                        SizedBox(height: 14),
                        _logIn(),
                        SizedBox(height: 14),
                        _goToSignUp(),
                        SizedBox(height: 14),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.input("Enter email address"),
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
          style: StyleConstants.kTextStyle,
          decoration: StyleConstants.input("Enter your password"),
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
          return Center(
            child: CircularProgressIndicator(
              color: Color(ColorConstants.kButtonColor),
            ),
          );
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
        child: Center(
          child: Text("Go to Sign Up"),
        ));
  }

  _errorDialog(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    )));
  }
}
