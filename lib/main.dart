import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:tweetvio/BackEnd/firebase/Online_Database_Management/new_user_entry.dart';
import 'package:tweetvio/FrontEnd/AuthUI/LogIn.dart';
import 'package:tweetvio/FrontEnd/MainScreens/main_screen.dart';
import 'package:tweetvio/FrontEnd/NewUserEntry/new_user_entry.dart';
//import 'FrontEnd/AuthUI/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Tweetvio',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: await differentContextDecisionTake(),
    ),
  );
}

Future<Widget> differentContextDecisionTake() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return LogInScreen();
  } else {
    final CloudStoreDataManagement _cloudStoreDataManagement =
        CloudStoreDataManagement();
    final bool _dataPresentResponse =
        await _cloudStoreDataManagement.userRecordPresentOrNot(
            email: FirebaseAuth.instance.currentUser!.email.toString());
    return _dataPresentResponse ? MainScreen() : TakePrimaryUserData();
  }
}
