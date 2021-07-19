import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/blocs/cubit/navigation_cubit.dart';
import 'package:logss/presentation/login/login_view.dart';
import 'package:logss/presentation/signup/signup_view.dart';

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
                child: SignUpPage(),
              ),
            if (state == NavigationState.LogIn)
              MaterialPage(
                child: LogInPage(),
              ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
