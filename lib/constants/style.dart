import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logss/constants/color.dart';

class StyleConstants {
  StyleConstants._();

//for textfield input text style
  static TextStyle kTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

//for logo used in sign up and login page
  static Widget kCompanyLogo = CircleAvatar(
    backgroundColor: Colors.green,
    radius: 40,
    child: Center(
      child: Text(
        "PRA",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static ButtonStyle? kButtonStyle = ElevatedButton.styleFrom(
    primary: Color(
      ColorConstants.kButtonColor,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        6,
      ),
    ),
  );

  //for sign up and login button
  static Widget kButtonText(String buttonText) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

//for sign up and log in header
  static Widget kAuthText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 28,
        color: Colors.white60,
        fontWeight: FontWeight.bold,
      ),
    );
  }

//for sign up and login details
  static Widget kAuthDetails(String details) {
    return Text(
      details,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.white24,
        fontWeight: FontWeight.w300,
      ),
    );
  }

//for signup and login textfield decoration
  static InputDecoration? input(String hintText) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.pink,
        ),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color(ColorConstants.kHintTextColor),
        fontSize: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
