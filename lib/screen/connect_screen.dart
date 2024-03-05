
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/connection_model.dart';
import 'package:nerdmine/model/user_connection_info_response.dart';
import 'package:nerdmine/screen/chat_page.dart';
import 'package:nerdmine/screen/profile_screen.dart';
import 'package:nerdmine/screen/user_info_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';
class ConnectScreen extends StatefulWidget {
  List<ConnectionModel> connectionList;

  ConnectScreen(this.connectionList);

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  UserConnectionInfoResponse? userConnectionInfoResponse;

  // List<ConnectionList> connectList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // getConnectInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F4F8),
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
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
            "Connections".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: MyColorName.colorBg1,
                padding: EdgeInsets.all(getWidth(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("${widget.connectionList.length ?? 0} Connections".toString(),
                        textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                   /* Image.asset(
                      "images/search.png",
                      color: MyColorName.colorTextPrimary,
                      width: getWidth(30),
                    )*/
                  ],
                ),
              ),
              boxHeight(30),
              widget.connectionList.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
                      child: ListView.separated(
                          itemCount: widget.connectionList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return boxHeight(20);
                          },
                          itemBuilder: (context, index) {
                            ConnectionModel model = widget.connectionList[index];
                            return ListTile(
                              onTap: () {
                                callChat(model);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              tileColor: MyColorName.colorBg1,
                              contentPadding: EdgeInsets.all(10),
                              leading:  InkWell(
                                onTap: () {
                                  String userId = App.localStorage.getString("user_id") ?? "";

                                  if (userId == model.userId) {
                                    navigateScreen(context, ProfileScreen());
                                  } else {
                                    navigateScreen(context, UserProfileScreen(model.userId ?? ""));
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: commonImage(model.profileImage, 100.0, 100.0, "", context, ""),
                                ),
                              ),
                              title: text(getString(model.name.toString()),
                                  textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                              // trailing: InkWell(
                              //   onTap: () {
                              //     showUserProfileOptions();
                              //   },
                              //   child: Image.asset(
                              //     "images/menu.png",
                              //     width: getWidth(30),
                              //     height: getHeight(30),
                              //   ),
                              // ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boxHeight(10),
                                  text(getString(model.skills.toString()),
                                      textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                  text("Connected on ${model.connectionDate == null? "--" : getDuration(model.connectionDate!)}",
                                      textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                ],
                              ),
                            );
                          }),
                    )
                  : Center(
                      child: text("No Result Found", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool chatLoading =  false;

  callChat(ConnectionModel model) async {
    await App.init();

    var otherUser1 = types.User(
      firstName: model.name,
      id: model.fCId.toString(),
      imageUrl: model.profileImage.toString(),
      lastName: "",
    );
    _handlePressed(otherUser1, context,"".toString(),model);
  }

  _handlePressed(types.User otherUser, BuildContext context,String fcmID,ConnectionModel model) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    setState(() {
      chatLoading = false;
    });
    addChat(model.userId, room.id);
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
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

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

  Future<void> getConnectInfo() async {
    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Dialogs.showLoader(context, "Getting connection details...");
    String userId = "2";
    /*App.localStorage.getString("user_id") ?? ""*/;

    UserConnectionInfoResponse response =
        await apiController.get<UserConnectionInfoResponse>("${EndPoints.USER_CONNECTION_INFO}/$userId");

    //hide loader
    await Dialogs.hideLoader(context);
    if (response.status ?? false) {
      userConnectionInfoResponse = response;
      // connectList = userConnectionInfoResponse?.info?.connectionInfo?.connectionList ?? [];

      //Update UI
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }
  }

  void showUserProfileOptions() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  ...["Send Message", "Unfollow ", "Remove connection", "Mute Pratik"].map((e) => InkWell(
                    onTap: () {
                      // selectedPostVisibilityString = e.typeTitle;
                      // Navigator.pop(context);
                      // setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          horizontalSpace(20.0),
                          text(e ?? "N/A", textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 12.sp),
                        ],
                      ),
                    ),
                  )),
                  verticalSpace(20.0),
                ],
              ),
            )
          ]);
        });
  }

}
