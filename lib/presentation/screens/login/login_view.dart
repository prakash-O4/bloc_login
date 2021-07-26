import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/FormSubmissionStatus.dart';
import 'package:logss/presentation/blocs/Login/login_bloc.dart';
import 'package:logss/presentation/blocs/cubit/session_cubit.dart';
import 'package:logss/common/constants/color.dart';
import 'package:logss/presentation/blocs/cubit/navigation_cubit.dart';
import 'package:logss/presentation/screens/login/log_in_widget.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        navigationCubit: BlocProvider.of<NavigationCubit>(context),
        sessionCubit: BlocProvider.of<SessionCubit>(context),
      ),
      child: Scaffold(
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
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                //only shows snack bar when there is unique state when state repeats
                //the it will returns false and listener will not be called.
                listenWhen: (previous, current) {
                  var _previous = previous.status;
                  var _current = current.status;
                  if (_previous != _current) {
                    return true;
                  }
                  return false;
                },
                child: LogInWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
