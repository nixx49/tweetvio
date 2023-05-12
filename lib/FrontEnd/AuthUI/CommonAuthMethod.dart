import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tweetvio/FrontEnd/AuthUI/SignUp.dart';

import 'LogIn.dart';

Widget commonTextFormField(BuildContext context,
    {required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController textEditingController,
    dynamicOutlineInputBorder}) {
  return Container(
    width: MediaQuery.of(context).size.width - 10.0,
    padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
    child: TextFormField(
      validator: validator,
      controller: textEditingController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white70,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}

/*
Widget authButton(BuildContext context, String buttonName){
  return Padding(
    padding: const EdgeInsets.only(left: 50.0,right:50.0,top: 20.0),
    child: ElevatedButton (
      style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 50, 20.0),
          elevation: 5.0,
          primary: Color.fromRGBO(255, 16, 240, 1),
          padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
            top: 7.0,
            bottom: 7.0,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          )),
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 25.0,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () async {

      },
    ),
  );
}
*/

/*
Widget socialMediaIntegrationButtons() {
  return Container(
    width: double.maxFinite,
    // height: double.maxFinite,
    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print('Google Pressed');
          },
          child: Image.asset(
            'assets/images/google.png',
            width: 400.0,
          ),
        ),
        SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            print("Facebook Pressed");
          },
          child: Image.asset(
            'assets/images/facebook.png',
            width: 400.0,
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
*/

Widget switchAnotherScreen(
    BuildContext context, String buttonNameFirst, String buttonNameLast) {
  return ElevatedButton(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonNameFirst,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13.0,
            letterSpacing: 0.25,
          ),
        ),
        Text(
          buttonNameLast,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            letterSpacing: 0.25,
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      primary: Color.fromRGBO(0, 48, 143, 0.3),

      // shape: RoundedRectangleBorder(
      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
      // ),
    ),
    onPressed: () {
      if (buttonNameLast == "Log In")
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LogInScreen()));
      else
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SignUpPage()));
    },
  );
}
