import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/blocs/Login/login_bloc.dart';
import 'package:logss/blocs/SignUp/signup_bloc.dart';
import 'package:logss/cubit/navigation_cubit.dart';
import 'package:logss/presentation/home/home_view.dart';
import 'package:logss/presentation/login_view.dart';
import 'package:logss/presentation/signup_view.dart';

class AuthNavigation extends StatefulWidget {
  const AuthNavigation({Key? key}) : super(key: key);

  @override
  _AuthNavigationState createState() => _AuthNavigationState();
}

class _AuthNavigationState extends State<AuthNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state == NavigationState.SignUp)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => SignupBloc(
                    navigationCubit: BlocProvider.of<NavigationCubit>(context),
                  ),
                  child: SignUpPage(),
                ),
              ),
            if (state == NavigationState.LogIn)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => LoginBloc(
                      navigationCubit:
                          BlocProvider.of<NavigationCubit>(context)),
                  child: LogInPage(),
                ),
              ),
            if (state == NavigationState.HomePage)
              MaterialPage(
                child: HomePage(),
              ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
