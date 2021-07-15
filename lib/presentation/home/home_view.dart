import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logss/blocs/cubit/session_cubit.dart';
import 'package:logss/constants/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstants.kBackgroundColor),
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color(ColorConstants.kBackgroundColor),
        title: Text("Mero kam"),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<SessionCubit>(context).logOut();
            },
            icon: Icon(Icons.logout, size: 20),
          )
        ],
      ),
      body: Center(
        child: Text(
          "Hello",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.white30,
            ),
          ),
        ),
      ),
    );
  }
}
