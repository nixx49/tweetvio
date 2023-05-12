import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tweetvio/BackEnd/firebase/Auth/email_and_pwd_auth.dart';
import 'package:tweetvio/BackEnd/firebase/Auth/google_auth.dart';
import 'package:tweetvio/FrontEnd/AuthUI/LogIn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  //State<StatefulWidget> createState() {
  _HomePageState createState() => _HomePageState();
//throw UnimplementedError();
}

class _HomePageState extends State<HomePage> {
  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();

  // final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Log Out'),
              onPressed: () async {
                final bool googleResponse =
                    await this._googleAuthentication.logOut();

                if (!googleResponse) //{

                  // final bool fbResponse = await this._facebookAuthentication.logOut();
                  // }else{
                  //if(!fbResponse)
                  // await this._emailAndPasswordAuth.logOut();
                  // }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LogInScreen()),
                      (route) => false);
              },
            )));
  }
/*
  Future<bool>userRecordPresentOrNot({required String email}) async{
    try{
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =await FirebaseFirestore.doc('${this._collectionName}/$email').get();
      return documentSnapshot.exists;
    }catch(e){
      print('Error in user Record Present or not: ${e.toString()}');
      return false;
    }
  }
*/
}
