import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tweetvio/BackEnd/firebase/Auth/email_and_pwd_auth.dart';

//import 'package:tweetvio/BackEnd/firebase/Auth/fb_auth.dart';
import 'package:tweetvio/BackEnd/firebase/Auth/google_auth.dart';
import 'package:tweetvio/FrontEnd/MainScreens/Home_Page.dart';
import 'package:tweetvio/FrontEnd/NewUserEntry/new_user_entry.dart';
import 'package:tweetvio/GlobalUser/enum_tweetvio.dart';
import 'package:tweetvio/GlobalUser/reg_exp.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'CommonAuthMethod.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();

  // final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: this._isLoading,
          color: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.pink, Colors.blue],
              ),
            ),
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tweetvioo.png',
                        width: 230.0,
                      ),
                    ],
                  ),
                ),
                //   ),
                //Center(
                //  child: Text(
                //   'Sign Up',
                //   style: TextStyle(fontSize: 23.0, color: Colors.white),
                //  ),
                //  ),

                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Form(
                    key: this._logInKey,
                    child: ListView(
                      children: [
                        commonTextFormField(context, hintText: 'Email',
                            validator: (String? inputVal) {
                          if (!emailRegex.hasMatch(inputVal.toString()))
                            return 'Email format not Matching';
                          return null;
                        }, textEditingController: this._email),
                        commonTextFormField(context, hintText: 'Password',
                            validator: (String? inputVal) {
                          if (inputVal!.length < 6)
                            return 'Password must be at least 6 characters';
                          return null;
                        }, textEditingController: this._pwd),
                        logInAuthButton(context, 'Log In'),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Or',
                    style: TextStyle(color: Colors.white70, fontSize: 20.0),
                  ),
                ),
                logInSocialMediaIntegrationButtons(),
                switchAnotherScreen(
                    context, "Don't have an account? ", "Sign Up"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logInAuthButton(BuildContext context, String buttonName) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
      child: ElevatedButton(
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
          if (this._logInKey.currentState!.validate()) {
            print('Validated');
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            if (mounted) {
              setState(() {
                this._isLoading = true;
              });
            }

            final EmailSignInResults emailSignInResults =
                await _emailAndPasswordAuth.signInWithEmailAndPassword(
                    email: this._email.text, pwd: this._pwd.text);
            String msg = '';
            if (emailSignInResults == EmailSignInResults.SignInCompleted)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => TakePrimaryUserData()),
                  (route) => false);
            else if (emailSignInResults ==
                EmailSignInResults.EmailNotVerified) {
              msg =
                  'Email not Verified.\nPlease Verify your email and then Log In';
            } else if (emailSignInResults ==
                EmailSignInResults.EmailOrPasswordInvalid)
              msg = 'Email and Passward Invalid';
            else
              msg = 'Sign In not Completed';
            if (msg != '')
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));

            if (mounted) {
              setState(() {
                this._isLoading = false;
              });
            }
          } else {
            print('Not Validated');
          }
        },
      ),
    );
  }

  Widget logInSocialMediaIntegrationButtons() {
    return Container(
      width: double.maxFinite,
      // height: double.maxFinite,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              print('Google Pressed');
              if (mounted) {
                setState(() {
                  this._isLoading = true;
                });
              }

              final GoogleSignInResults _googleSignInResults =
                  await this._googleAuthentication.signInWithGoogle();
              String msg = '';
              if (_googleSignInResults == GoogleSignInResults.SignInCompleted) {
                msg = ' Sign In Completed';
                //Navigator.pushAndRemoveUntil(
                // context,
                //  MaterialPageRoute(builder: (_) => HomePage()),
                //      (route) => false);
              } else if (_googleSignInResults ==
                  GoogleSignInResults.SignInNotCompleted)
                msg = 'Sign In Not Completed';
              else if (_googleSignInResults ==
                  GoogleSignInResults.AlreadySignedIn)
                msg = 'Already Google SignedIn';
              else
                msg = 'Unexpected Error Happen';

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));

              if (_googleSignInResults == GoogleSignInResults.SignInCompleted)
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => TakePrimaryUserData()),
                    (route) => false);

              if (mounted) {
                setState(() {
                  this._isLoading = false;
                });
              }
            },
            child: Image.asset(
              'assets/images/google.png',
              width: 400.0,
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () async {
              print("Facebook Pressed");
              //if(mounted){
              //   setState((){
              //      this._isLoading = true;
              //    });
              //   }

              //   final FBSignInResults _fbSignInResults = await this._facebookAuthentication.facebookLogIn();
              //   String msg ='';
              //   if(_fbSignInResults == FBSignInResults.SignInCompleted) {
              //    msg = ' Sign In Completed';
              //Navigator.pushAndRemoveUntil(
              // context,
              //  MaterialPageRoute(builder: (_) => HomePage()),
              //      (route) => false);
              //   }else if(_fbSignInResults == FBSignInResults.SignInNotCompleted)
              //   msg = 'Sign In Not Completed';
              //   else if(_fbSignInResults == FBSignInResults.AlreadySignIn)
              //    msg = 'Already Google SignedIn';
              //   else
              //   msg = 'Unexpected Error Happen';

              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

              //  if(_fbSignInResults == FBSignInResults.SignInCompleted)
              //   Navigator.pushAndRemoveUntil(
              //      context,
              //      MaterialPageRoute(builder: (_) => HomePage()),
              //        (route) => false);

              //  if(mounted){
              //   setState((){
              //    this._isLoading = false;
              //  });
              //}
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
}
