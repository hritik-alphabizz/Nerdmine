
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/chat_model.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/model/connection_model.dart';
import 'package:nerdmine/screen/chat_page.dart';
import 'package:nerdmine/screen/manage_connection.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class ChatListScreen extends StatefulWidget {

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool selected =false;

  List<ChatModel> tempChat = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getChats()async{
    
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl+"initiateChatList/${curUserId}"));
    if(response['status']){
      setState(() {
        loading = false;
      });
      for(var v in response['list']){
        tempChat.add(ChatModel.fromJson(v));
      }
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Chats".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // InkWell(
              //   onTap: () {
              //     navigateScreen(context, SearchScreen());
              //   },
              //   child: Container(
              //     decoration: boxDecoration(
              //       bgColor: MyColorName.primaryDark,
              //       radius: 100,
              //     ),
              //     margin: EdgeInsets.all(getWidth(10)),
              //     padding: EdgeInsets.all(getHeight(15)),
              //     child: Center(child: Image.asset("images/search.png")),
              //   ),
              // ),
              boxHeight(30),
              tempChat.length>0?Container(
                padding: EdgeInsets.symmetric(horizontal:getWidth(30)),
                child: ListView.separated(
                    itemCount: tempChat.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context,index){

                      return boxHeight(20);
                    },
                    itemBuilder: (context,index){
                      ChatModel model= tempChat[index];
                      return ListTile(
                        onTap: (){
                          callChat(model);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: MyColorName.colorBg1,
                        contentPadding: EdgeInsets.all(10),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: commonImage(model.profileImagePath,
                                100.0, 100.0, "", context, "")),
                        title:  text(getString(model.name.toString()),textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp),
                        trailing:Image.asset("images/menu.png",width: getWidth(30),height: getHeight(30),),
                        subtitle:   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boxHeight(10),
                            text(getString(model.skills.toString()),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                            text("Chat Started ${getDuration(model.initiateDate!)}",textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                          ],
                        ),
                      );
                    }),
              ) : Center(
                child: text("No Result Found",
                    textColor: MyColorName.primaryDark,
                    fontFamily: fontMedium,
                    fontSize: 10.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool chatLoading =  false;

  callChat(ChatModel model) async {
    await App.init();

    var otherUser1 = types.User(
      firstName: model.name,
      id: model.fCId.toString(),
      imageUrl: model.profileImage.toString(),
      lastName: "",
    );
    _handlePressed(otherUser1, context,"".toString(),model);
  }

  _handlePressed(types.User otherUser, BuildContext context,String fcmID,ChatModel model) async {

   print(otherUser);
   print(otherUser);

    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    setState(() {
      chatLoading = false;
    });
 //   addChat(otherUser.id, room.id);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          name: model.name.toString(),
          email: model.email.toString(),
          room: room,
          fcm: fcmID,
        ),
      ),
    );
  }
  bool isNetwork = false;
  addChat(id,roomID) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "chat_with_user_id": id,
          "chat_room_id":roomID,
        };
        Map response = await apiBaseHelper.postAPICall(
            Uri.parse(baseUrl + "initiateChat"), data);
        print(response);
        bool status = true;
        /* setState(() {
          loading = false;
        });*/
        if (response['status']) {

        } else {}
        String msg = response['msg'];
        //setSnackbar(msg, context);
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }
}
