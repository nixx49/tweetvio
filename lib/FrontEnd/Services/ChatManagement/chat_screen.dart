import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:animations/animations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:circle_list/circle_list.dart';


class ChatScreen extends StatefulWidget {
  final String userName;

  ChatScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isLoading = false;
  bool _writeTextPresent = false;
  bool _lastDirection = false;

  final String _messageAndTimeSeparator = "[[[Message_And_Time_Separator]]]";

  List<String> _allConversationMessages = [
    "hii..[[[Message_And_Time_Separator]]]10:20",
    "Hii.. I'm Nimantha[[[Message_And_Time_Separator]]]11:30"
  ];

  List<bool> _conversationMessageHolder = [true, false];

  final TextEditingController _typedText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(7, 0, 26, 1),
        //bottomSheet: _bottomSheet(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(153, 0, 153, 1),
          //elevation: 10.0,
          // shadowColor: Colors.black54,
          // title:Container (
          //    width: double.maxFinite,
          //   color: Colors.black54,
          //   alignment: Alignment.center,
          //child:
          title: Text(widget.userName),

          leading: Row(
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: OpenContainer(
                  closedColor: const Color.fromRGBO(25, 39, 52, 1),
                  middleColor: const Color.fromRGBO(25, 39, 52, 1),
                  openColor: const Color.fromRGBO(25, 39, 52, 1),
                  closedShape: CircleBorder(),
                  closedElevation: 0.0,
                  transitionType: ContainerTransitionType.fadeThrough,
                  transitionDuration: Duration(milliseconds: 500),
                  openBuilder: (_, __) {
                    return Center();
                  },
                  closedBuilder: (_, __) {
                    return CircleAvatar(
                      //radius: 23.0,
                      backgroundColor: const Color.fromRGBO(7, 0, 26, 1),
                      backgroundImage: ExactAssetImage(
                        'assets/images/setup.png',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.orange,
              ),
            ),
          ],
        ),

        body: LoadingOverlay(
          isLoading: this._isLoading,
          color: Colors.black54,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            // margin: EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height - 160,
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: this._allConversationMessages.length,
                    itemBuilder: (itemBuilderContext, index) {
                      return textConversationManagement(
                          itemBuilderContext, index);
                    },
                  ),
                ),
                /* Container(
                  width: double.maxFinite,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(20, 20, 20, 1), //Typing Area
                    //Colors.white12,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                  ),

                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.emoji_emotions_outlined,
                            color: Colors.orange),
                        onPressed: () {

                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: GestureDetector(
                          child: Icon(Entypo.link, color: Colors.orange),
                          onTap: _differentChatOptions,
                        ),
                      ),

                      Expanded(
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 60.0,
                          child: TextField(
                            controller: this._typedText,
                            style: TextStyle(color: Colors.white),
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: 'Type Here...',
                                hintStyle: TextStyle(color: Colors.white38),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54,
                                      width: 2.0),
                                )
                            ),
                            onChanged: (writeText) {
                              bool _isEmpty = false;
                              writeText.isEmpty ? _isEmpty = true : _isEmpty =
                              false;

                              if (mounted) {
                                setState(() {
                                  this._writeTextPresent = !_isEmpty;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: GestureDetector(
                          child: this._writeTextPresent ? Icon(
                              Icons.send, color: Colors.orange) : Icon(
                              Icons.keyboard_voice_rounded,
                              color: Colors.orange),
                          onTap: () {

                          },
                        ),
                      ),

                    ],
                  ),
                ),*/

                _bottomInsertionPortion(context),

              ],
            ),
          ),
        ),
      ),
    );
  }

/*  Widget _bottomSheet() {
    return BottomSheet(
      backgroundColor: const Color.fromRGBO(7, 0, 26, 1),
      builder: (BuildContext context) {
        return Container(
          width: double.maxFinite,
          height: 80.0,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(20, 20, 20, 1), //Typing Area
            //Colors.white12,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),

          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.emoji_emotions_outlined, color: Colors.orange),
                onPressed: () {

                },
              ),

              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                child: GestureDetector(
                  child: Icon(Entypo.link, color: Colors.orange),
                  onTap: _differentChatOptions,
                ),
              ),

              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 60.0,
                  child: TextField(
                    controller: this._typedText,
                    style: TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Type Here...',
                        hintStyle: TextStyle(color: Colors.white38),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54,
                              width: 2.0),
                        )
                    ),
                    onChanged: (writeText) {
                      bool _isEmpty = false;
                      writeText.isEmpty ? _isEmpty = true : _isEmpty = false;

                      if (mounted) {
                        setState(() {
                          this._writeTextPresent = !_isEmpty;
                        });
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: GestureDetector(
                  child: this._writeTextPresent ? Icon(
                      Icons.send, color: Colors.orange) : Icon(
                      Icons.keyboard_voice_rounded, color: Colors.orange),
                  onTap: () {

                  },
                ),
              ),

            ],
          ),
        );
      },
      onClosing: () {

      },

    );
  }*/

  void _differentChatOptions() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),

              elevation: 0.3,
              backgroundColor: Color.fromRGBO(34, 48, 60, 0.5),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/ 2.7,
                child: Center(
                child: CircleList(
                  initialAngle: 55,
                  outerRadius: MediaQuery.of(context).size.width / 3.2,
                  innerRadius: MediaQuery.of(context).size.width / 10,
                  showInitialAnimation: true,
                  innerCircleColor: Color.fromRGBO(153, 0, 153, 1),
                  outerCircleColor: Color.fromRGBO(0, 0, 0, 0.1),
                  origin: Offset(0, 0),
                  rotateMode: RotateMode.allRotate,
                  centerWidget: Center(
                    child: Text(
                      "Tweetvio",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25.0,
                        fontFamily: 'Signatra',
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white70,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          //_imageOrVideoSend(imageSource: ImageSource.camera);
                        },
                        onLongPress: () async {
                          //_imageOrVideoSend(imageSource: ImageSource.gallery);
                        },
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white70,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          // _imageOrVideoSend(
                          //     imageSource: ImageSource.camera, type: 'video');
                        },
                        onLongPress: () async {
                          // _imageOrVideoSend(
                          //     imageSource: ImageSource.gallery, type: 'video');
                        },
                        child: Icon(
                          Icons.video_collection,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white70,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          //_extraTextManagement(MediaTypes.Text);
                        },
                        child: Icon(
                          Icons.text_fields_rounded,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white70,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          //await _documentSend();
                        },
                        child: Icon(
                          Icons.document_scanner_outlined,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white70,
                            width: 3,
                          )),
                      child: GestureDetector(
                        onTap: () async {
                          // if (!await NativeCallback().callToCheckNetworkConnectivity())
                          //   _showDiaLog(titleText: 'No Internet Connection');
                          // else {
                          //   _showDiaLog(titleText: 'Wait for map');
                          //   await _locationSend();
                          // }
                        },
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white70,
                            width: 3,
                          )),
                      child: GestureDetector(
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                        onTap: () async {
                          //await _voiceSend();
                        },
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ));
  }

  Widget textConversationManagement(
      BuildContext itemBuilderContext, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: this._conversationMessageHolder[index]
              ? EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 3,
                  left: 5.0,
                )
              : EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 3,
                  right: 5.0,
                ),
          alignment: this._conversationMessageHolder[index]
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: this._conversationMessageHolder[index]
                      ? Color.fromRGBO(60, 80, 100, 1)
                      : Color.fromRGBO(102, 102, 255, 1),
                  elevation: 0.0,
                  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: this._conversationMessageHolder[index]
                          ? Radius.circular(0.0)
                          : Radius.circular(20.0),
                      topRight: this._conversationMessageHolder[index]
                          ? Radius.circular(20.0)
                          : Radius.circular(0.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                child: Text(
                  this
                      ._allConversationMessages[index]
                      .split(this._messageAndTimeSeparator)[0],
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                onPressed: () {},
                onLongPress: () {},
              ),
            ],
          ),
        ),
        Container(
          alignment: this._conversationMessageHolder[index]
              ? Alignment.centerLeft
              : Alignment.centerRight,
          margin: this._conversationMessageHolder[index]
              ? EdgeInsets.only(
                  left: 5.0,
                  bottom: 5.0,
                  top: 5.0,
                )
              : const EdgeInsets.only(
                  left: 5.0,
                  bottom: 5.0,
                  top: 5.0,
                ),
          child: _timeReFormat(this
              ._allConversationMessages[index]
              .split(this._messageAndTimeSeparator)[1]),
        ),
       /* SizedBox(
          height: 8.0,
        ),*/
      ],
    );
  }

  Widget _timeReFormat(String _willReturnTime) {
    if (int.parse(_willReturnTime.split(':')[0]) < 10)
      _willReturnTime = _willReturnTime.replaceRange(
          0, _willReturnTime.indexOf(':'), '0${_willReturnTime.split(':')[0]}');

    if (int.parse(_willReturnTime.split(':')[1]) < 10)
      _willReturnTime = _willReturnTime.replaceRange(
          _willReturnTime.indexOf(':') + 1,
          _willReturnTime.length,
          '0${_willReturnTime.split(':')[1]}');

    return Text(
      _willReturnTime,
      style: const TextStyle(color: Colors.lightBlue),
    );
  }

  Widget _bottomInsertionPortion(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 80.0,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(25, 39, 52, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.amber,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: GestureDetector(
              child: Icon(
                Entypo.link,
                color: Colors.lightBlue,
              ),
              onTap: _differentChatOptions,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              height: 60.0,
              child: TextField(
                controller: this._typedText,
                style: TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type Here...',
                  hintStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                  ),
                ),
                onTap: () {
                  if (mounted) {
                    setState(() {});
                  }
                },
                onChanged: (writeText) {
                  bool _isEmpty = false;
                  writeText.isEmpty ? _isEmpty = true : _isEmpty = false;

                  if (mounted) {
                    setState(() {
                      this._writeTextPresent = !_isEmpty;
                    });
                  }
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              child: this._writeTextPresent
                  ? Icon(
                      Icons.send,
                      color: Colors.green,
                      size: 30.0,
                    )
                  : Icon(
                      Icons.keyboard_voice_rounded,
                      color: Colors.green,
                      size: 30.0,
                    ),
              onTap: () {
                if (this._writeTextPresent) {
                  final String _messageTime =
                      "${DateTime.now().hour}:${(DateTime.now().minute)}";
                  if (mounted) {
                    setState(() {
                      this._allConversationMessages.add(
                          "${this._typedText.text}${this._messageAndTimeSeparator}$_messageTime");
                      this._conversationMessageHolder.add(this._lastDirection);
                      this._lastDirection = !this._lastDirection;
                      this._typedText.clear();
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}
