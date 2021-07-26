import 'package:flutter/material.dart';
import 'package:logss/common/constants/color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstants.kBackgroundColor),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(ColorConstants.kButtonColor),
        ),
      ),
    );
  }
}
