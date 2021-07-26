import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/presentation/blocs/SignUp/signup_bloc.dart';
import 'package:logss/presentation/blocs/cubit/session_cubit.dart';
import 'package:logss/common/constants/color.dart';
import 'package:logss/presentation/blocs/cubit/navigation_cubit.dart';
import 'package:logss/presentation/screens/signup/sign_up_widget.dart';


import '../../../FormSubmissionStatus.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(
        navigationCubit: BlocProvider.of<NavigationCubit>(context),
        sessionCubit: BlocProvider.of<SessionCubit>(context),
      ),
      child: Scaffold(
        backgroundColor: const Color(ColorConstants.kBackgroundColor),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 18,
                top: 20,
              ),
              child: BlocListener<SignupBloc, SignupState>(
                listener: (context, state) {
                  var _status = state.status;
                  if (_status is SubmissionFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _status.exception,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                listenWhen: (previous, current) {
                  var _previous = previous.status;
                  var _current = current.status;
                  if (_previous != _current) {
                    return true;
                  }
                  return false;
                },
                child: SignUpWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
