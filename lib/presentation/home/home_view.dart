import 'package:flutter/material.dart';
import 'package:logss/constants/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstants.kBackgroundColor),
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Color(ColorConstants.kBackgroundColor),
        title: Text("Mero kam"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout, size: 20))
        ],
      ),
      body: Container(
        child: SizedBox.shrink(),
      ),
    );
  }
}
