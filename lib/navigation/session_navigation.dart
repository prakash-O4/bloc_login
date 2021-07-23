import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/blocs/cubit/navigation_cubit.dart';
import 'package:logss/blocs/cubit/session_cubit.dart';
import 'package:logss/loading_view.dart';
import 'package:logss/navigation/auth_navigation.dart';
import 'package:logss/presentation/home/home_view.dart';

class SessionNavigation extends StatefulWidget {
  const SessionNavigation();

  @override
  _SessionNavigationState createState() => _SessionNavigationState();
}

class _SessionNavigationState extends State<SessionNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        // print(state.toString());
        return Navigator(
          pages: [
            if (state is Authenticated)
              MaterialPage(
                child: HomePage(user: state.user),
              ),
            if (state is UnAuthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => NavigationCubit(),
                  child: AuthNavigation(),
                ),
              ),
            if (state is UnknownState) MaterialPage(child: LoadingPage()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
