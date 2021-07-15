import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/blocs/cubit/session_cubit.dart';
import 'package:logss/navigation/session_navigation.dart';
// import 'package:logss/presentation/login_view.dart';
// import 'package:logss/presentation/signup_view.dart';
// import 'blocs/Login/login_bloc.dart';
// import 'blocs/SignUp/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => SessionCubit(),
        child: SessionNavigation(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
