import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';


import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  String name,email;
  final types.Room room;
  final fcm;

  ChatPage({required this.name,required this.email,required this.room, this.fcm});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
/*  Widget avatarBuilder(String? userId){
    return Image.asset(Assets.imagesUser);
  }
 Widget bubbleBuild(Widget child, {
    required types.Message message,
    required bool nextMessageInGroup,
  }){
    if(message is types.PartialText){
      return Container(
          child: text(message..toString(),textColor: Colors.black));
    }
    return Container(
        child: text(message.author.firstName.toString(),textColor: Colors.black));
  }*/
  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      //await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {

    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
   // addMessage(message.text.toString());
  //  addNote(widget.fcm, widget.room.users[1].firstName.toString(), message.text.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }
  getDetails(){
    for(int i =0;i<widget.room.users.length;i++){
      print(widget.room.users[i].firstName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F4F8),
        appBar: AppBar(
          centerTitle: true,
          leading:  InkWell(
            onTap: (){
              back(context);
            },
            child: Container(
                decoration: boxDecoration(
                  bgColor: MyColorName.colorTextThird,
                  radius: 5.sp,
                ),
                height: getWidth(50),
                width: getWidth(50),
                margin: EdgeInsets.all(getWidth(10)),
                padding: EdgeInsets.all(getWidth(20)),
                child: Image.asset(
                  Assets.imagesBack, fit: BoxFit.fill,
                )),
          ),
          backgroundColor: Color(0xffF2F4F8),
          elevation: 1,
          title: text(
              widget.name.toString(),
              textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
          ),
          /*actions: [
            Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/search.png")),
            ),
            Container(
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/menu.png")),
            ),
          ],*/
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return StreamBuilder<List<types.Message>>(
                initialData: const [],
                stream: FirebaseChatCore.instance.messages(snapshot.data!),
                builder: (context, snapshot) {
                  return Chat(
                  //  avatarBuilder: avatarBuilder,
                    messages: snapshot.data ?? [],

                    onMessageTap: _handleMessageTap,
                   // onAttachmentPressed: _handleAtachmentPressed,
                   // bubbleBuilder: bubbleBuild,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: _handleSendPressed,
                    showUserAvatars: true,
                    theme: DefaultChatTheme(
                      deliveredIcon: Icon(Icons.check_circle,color: Colors.green,),
                      seenIcon:Icon(Icons.check,color: Colors.green,) ,
                      primaryColor: MyColorName.primaryDark,
                        inputContainerDecoration: boxDecoration(
                            radius: 10,
                            bgColor: Color(0xffF3F3F5),
                          color: Colors.grey.shade300,
                          showShadow: true,
                        ),

                      inputMargin: EdgeInsets.all(getWidth(20)),
                      inputTextColor: MyColorName.colorTextSecondary,
                      inputBackgroundColor: Colors.white,
                      backgroundColor:  Color(0xffF2F4F8),
                    ),
                    user: types.User(
                      id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                      imageUrl: FirebaseChatCore.instance.firebaseUser?.photoURL ?? '',
                      firstName: FirebaseChatCore.instance.firebaseUser?.displayName ?? '',
                    ),
                  );
                },
              );
            }else{
              return Chat(
                messages:  [],
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                theme: DefaultChatTheme(
                  primaryColor: MyColorName.primaryDark,
                  seenIcon:Icon(Icons.check,color: Colors.green,) ,
                  inputContainerDecoration: boxDecoration(
                    radius: 10,
                    bgColor: Color(0xffF3F3F5),
                    color: Colors.grey.shade300,
                    showShadow: true,
                  ),
                  deliveredIcon: Icon(Icons.check_circle,color: Colors.green,),
                  inputMargin: EdgeInsets.all(getWidth(20)),
                  inputTextColor: MyColorName.colorTextSecondary,
                  inputBackgroundColor: Colors.white,
                  backgroundColor:  Color(0xffF2F4F8),
                ),
                user: types.User(
                  id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                  imageUrl: FirebaseChatCore.instance.firebaseUser?.photoURL ?? '',
                  firstName: FirebaseChatCore.instance.firebaseUser?.displayName ?? '',

                ),
              );
            }

          },
        ),
      ),
    );
  }
  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
               //   _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
               //   _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


/*  bool _isNetworkAvail = true;
  Future<Null> addMessage(body) async {
    await App.init();
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {
        var parameter = {"from_user_id": curUserId,  "to_user_id": widget.model.userId,"message":body,"type":"1"};
        print(parameter);
        Response response =
        await post(Uri.parse(baseUrl+"setMessage"), body: parameter, headers: {})
            .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);
        print(getdata);
      } on TimeoutException catch (_) {
        setSnackbar("Something Wrong",context);
      }
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;

        });
    }

    return null;
  }
  Future<Null> addNote(fcm,title,body) async {
    await App.init();
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      try {

        var parameter = {"title": title,  "fcm_id": fcm,"body":body};
        print(parameter);
        Response response =
        await post(Uri.parse(""), body: parameter, headers: {})
            .timeout(Duration(seconds: timeOut));

        var getdata = json.decode(response.body);
        print(getdata);
        bool error = getdata["error"];
        String? msg = getdata["message"];

        if (!error) {

        }

      } on TimeoutException catch (_) {
        setSnackbar("Something Wrong",context);
      }
    } else {
      if (mounted)
        setState(() {
          _isNetworkAvail = false;

        });
    }

    return null;
  }*/
}
