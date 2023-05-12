import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tweetvio/BackEnd/Sqlite_Management/local_database_management.dart';
import 'package:tweetvio/BackEnd/firebase/Online_Database_Management/new_user_entry.dart';
import 'package:tweetvio/FrontEnd/AuthUI/CommonAuthMethod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweetvio/FrontEnd/MainScreens/Home_Page.dart';
import 'package:tweetvio/FrontEnd/MainScreens/main_screen.dart';

class TakePrimaryUserData extends StatefulWidget {
  const TakePrimaryUserData({Key? key}) : super(key: key);

  @override
  _TakePrimaryUserDataState createState() => _TakePrimaryUserDataState();
}

class _TakePrimaryUserDataState extends State<TakePrimaryUserData> {
  bool _isLoading = false;

  final GlobalKey<FormState> _takeUserPrimaryInformationKey =
      GlobalKey<FormState>();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userAbout = TextEditingController();
  final CloudStoreDataManagement _cloudStoreDataManagement =
      CloudStoreDataManagement();

  final LocalDatabase _localDatabase = LocalDatabase();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: LoadingOverlay(
        isLoading: this._isLoading,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.pink, Colors.blue],
            ),
          ),
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: this._takeUserPrimaryInformationKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                _upperHeading(),
                SizedBox(
                  height: 40.0,
                ),
                commonTextFormField(context, hintText: 'User Name',
                    // dynamicOutlineInputBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    validator: (inputUserName) {
                  final RegExp _messageRegex = RegExp(r'[a-zA-Z0-9]');
                  if (inputUserName!.length < 6)
                    return "User Name must have 6 characters";
                  else if (inputUserName.contains(' ') ||
                      inputUserName.contains('@'))
                    return "Space and @ Not Allowed...User '__' instead of space";
                  else if (inputUserName.contains('__'))
                    return "'__' Not Allowed...User '__' instead of '__'";
                  else if (!_messageRegex.hasMatch(inputUserName))
                    return "Sorry,Only Emoji Not Supported";
                  return null;
                }, textEditingController: this._userName),
                commonTextFormField(context, hintText: 'About User',
                    validator: (String? inputVal) {
                  if (inputVal!.length < 6)
                    return 'About User must have 6 characters';
                  return null;
                }, textEditingController: this._userAbout),
                _saveUserPrimaryInformation(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _upperHeading() {
    return Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/setup.png',
            width: 70.0,
            height: 70.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Set Up Your Account',
            style: TextStyle(color: Colors.white, fontSize: 23.0),
          ),
        ],
      ),
    );
  }

  Widget _saveUserPrimaryInformation() {
    return Padding(
      padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 20.0),
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
            'Save',
            style: TextStyle(
              // borderRadius: BorderRadius.all(Radius.circular(20.0)),
              fontSize: 25.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () async {
            if (this._takeUserPrimaryInformationKey.currentState!.validate()) {
              print('Validated');

              SystemChannels.textInput.invokeMethod('TextInput.hide');

              if (mounted) {
                setState(() {
                  this._isLoading = true;
                });
              }

              final bool canRegisterNewUser = await _cloudStoreDataManagement
                  .checkThisUserAlreadyPresentOrNot(
                      userName: this._userName.text);
              String msg = '';
              if (!canRegisterNewUser)
                msg = 'User Name Already Present';
              else {
                final bool _userEntryResponse =
                    await _cloudStoreDataManagement.registerNewUser(
                        userName: this._userName.text,
                        userAbout: this._userAbout.text,
                        userEmail: FirebaseAuth.instance.currentUser!.email
                            .toString());
                if (canRegisterNewUser) {
                  msg = 'User data Entry Successfully';

                  await this._localDatabase.createTableToStoreImportantData();
                  final Map<String,dynamic> _importantFetchedData = await _cloudStoreDataManagement.getTokenFromCloudStore(userMail: FirebaseAuth.instance.currentUser!.email.toString());
                  await this._localDatabase.insertOrUpdateDataForThisAccount(
                      userName: this._userName.text,
                      userMail: FirebaseAuth.instance.currentUser!.email.toString(),
                      userToken: _importantFetchedData["token"],
                      userAbout: this._userAbout.text,
                      userAccCreationDate: _importantFetchedData["date"],
                      userAccCreationTime: _importantFetchedData["time"]);

                  await _localDatabase
                      .createTableForUserActivity(tableName: this._userName.text);


                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => MainScreen()),
                      (route) => false);
                } else
                  msg = 'User data Not Entry Successfully';
              }

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('msg')));

              if (mounted) {
                setState(() {
                  this._isLoading = false;
                });
              }
            } else {
              print('Not Validated');
            }
          }),
    );
  }
}
