
import 'dart:async';

import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/connection_model.dart';
import 'package:nerdmine/screen/chat_screen.dart';
import 'package:nerdmine/screen/connect_screen.dart';
import 'package:nerdmine/screen/manage_connection.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/screen/profile_screen.dart';
import 'package:nerdmine/screen/request_screen.dart';
import 'package:nerdmine/screen/user_info_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnection();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true,acceptStatus = false,connectionStatus = false;
  getConnection() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(
        baseUrl + "userConnectionInfo/$curUserId")); //todo change this user id
    setState(() {
      loading = false;
    });
    if (response['status']) {
      for (var v in response['info']['connection_info']['connection_list']) {
        connectionList.add(ConnectionModel.fromJson(v));
      }
      for (var v in response['info']['request_connection_info']['request_list']) {
        requestList.add(RequestModel.fromJson(v));
      }
      for (var v in response['info']['people_you_may_know']) {
        peopleList.add(PeopleModel.fromJson(v));
      }
    }
  }

  bool isNetwork = false;
  acceptConnection(id, status1) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "connection_request_id": id,
          "status": status1,
        };
        Map response = await apiBaseHelper.postAPICall(
            Uri.parse(baseUrl + "connectionRequestAcceptORReject"), data);
        print(response);
        bool status = true;
        setState(() {
          acceptStatus = false;
        });
        if (response['status']) {
          setState(() {
             connectionList = [];
             requestList = [];
            peopleList = [];
          });
          getConnection();
        } else {}
        String msg = response['msg'];
        // setSnackbar(msg, context);
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

  sendConnection(sendId, receiveId, model) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "sender_user_id": sendId,
          "receiver_user_id": receiveId,
        };
        Map response = await apiBaseHelper.postAPICall(
            Uri.parse(baseUrl + "sendConnectionRequest"), data);
        print(response);
        bool status = true;
        setState(() {
          connectionStatus = false;
        });
        if (response['status']) {
          setState(() {
            connectionList = [];
            requestList = [];
            peopleList = [];
          });
          getConnection();
        } else {
          if (response['msg'] == "You have already sent the request") {
            model.connectionStatus = false;
            setState(() {});
            FlutterToastX.showErrorToastBottom(context, response['msg']);
          }
        }
        String msg = response['msg'];
        // setSnackbar(msg, context);
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

  int length = 0;
  List<ConnectionModel> connectionList = [];
  List<RequestModel> requestList = [];
  List<PeopleModel> peopleList = [];

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
            "Connections".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
        actions: [
          InkWell(
            onTap: () {
              navigateScreen(context, NotificationScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/notify.png")),
            ),
          ),

          InkWell(
            onTap: (){
              navigateScreen(context, ChatListScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/msg.png")),
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boxHeight(30),
              GestureDetector(
                onTap: (){
                  navigateScreen(context, ManageScreen());
                },
                child: Container(
                  height: getHeight(90),
                  decoration: boxDecoration(
                    bgColor: MyColorName.colorBg1,
                    radius: 48.sp,
                    color: Color(0xff707070),
                  ),
                  child: Center(
                    child: text("Manage Connection",
                        textColor: MyColorName.colorTextPrimary,
                        fontFamily: fontRegular,
                        isLongText: true,
                        fontSize: 12.sp),
                  ),
                ),
              ),
              boxHeight(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{
                        var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> RequestScreen(requestList.toList())));
                        if(result!=null&&result){
                          setState(() {
                            connectionList = [];
                            requestList = [];
                            peopleList = [];
                          });
                          getConnection();
                        }
                      },
                      child: Container(
                        height: getHeight(90),
                        decoration: boxDecoration(
                          bgColor: MyColorName.colorBg1,
                          radius: 48.sp,
                          color: Color(0xff707070),
                        ),
                        child: Center(
                          child: text("Request",
                              textColor: MyColorName.colorTextPrimary,
                              fontFamily: fontRegular,
                              isLongText: true,
                              fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                  boxWidth(20),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        navigateScreen(context, ConnectScreen(connectionList.toList()));
                      },
                      child: Container(
                        height: getHeight(90),
                        decoration: boxDecoration(
                          bgColor: MyColorName.colorBg1,
                          radius: 48.sp,
                          color: Color(0xff707070),
                        ),
                        child: Center(
                          child: text("Connection",
                              textColor: MyColorName.colorTextPrimary,
                              fontFamily: fontRegular,
                              isLongText: true,
                              fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              boxHeight(30),
              requestList.length>0?Container(
                decoration: boxDecoration(
                  bgColor: Colors.white,
                  radius: 8,
                ),
                padding: EdgeInsets.all(getWidth(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                        "Request".toString(),
                        textColor: MyColorName.primaryDark,fontFamily: fontRegular,fontSize: 10.sp
                    ),
                   ListView.builder(
                        itemCount: requestList.length>2?2:requestList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          RequestModel model = requestList[index];
                          return ListTile(
                            contentPadding: EdgeInsets.all(10),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: commonImage(model.profileImage,
                                    100.0, 100.0, "", context, "")),
                            title:  text(getString(model.name.toString()),textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 10.sp),
                            trailing:!acceptStatus?Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      acceptStatus = true;
                                    });
                                    acceptConnection(model.connectionRequestId,"2");
                          },
                                  child: Container(
                                    width: getHeight(60),
                                    height: getHeight(60),
                                    decoration: boxDecoration(
                                      bgColor: MyColorName.colorBg1,
                                      radius: 30.sp,
                                      color: MyColorName.colorTextSecondary,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.close,color: MyColorName.colorTextSecondary,),
                                    ),
                                  ),
                                ),
                                boxWidth(10),
                                InkWell(
                                  onTap:(){
                                    setState(() {
                                      acceptStatus = true;
                                    });
                                    acceptConnection(model.connectionRequestId,"1");
                          },
                                  child: Container(
                                    width: getHeight(60),
                                    height: getHeight(60),
                                    decoration: boxDecoration(
                                      bgColor: MyColorName.colorBg1,
                                      radius: 30.sp,
                                      color: MyColorName.primaryDark,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.check,color: MyColorName.primaryDark,),
                                    ),
                                  ),
                                ),
                              ],
                            ):CircularProgressIndicator(color: MyColorName.colorBg1,),
                            subtitle:   Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(model.skills.toString(),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                               /* Row(
                                  children: [
                                    Image.asset("images/mutual.png",width: getWidth(30),height: getHeight(30),),
                                    text("7 Mutual connections",textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                                  ],
                                ),*/
                              ],
                            ),
                          );
                        }),
                    Center(
                      child: InkWell(
                        onTap: ()async{
                          var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestScreen(requestList.toList())));
                          if(result!=null&&result){
                            setState(() {
                              connectionList = [];
                              requestList = [];
                              peopleList = [];
                            });
                            getConnection();
                          }
                        },
                        child: text(
                            "Show More".toString(),
                            textColor: MyColorName.colorTextPrimary,fontFamily: fontBold,fontSize: 10.sp,isCentered: true
                        ),
                      ),
                    ),
                  ],
                ),
              ):SizedBox(),
              boxHeight(30),
              peopleList.length>0?text(
                  "People you may know".toString(),
                  textColor: MyColorName.primaryDark,fontFamily: fontRegular,fontSize: 10.sp
              ):SizedBox(),
              boxHeight(15),
              peopleList.length > 0
                  ? ListView.separated(
                      itemCount: peopleList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return boxHeight(20);
                      },
                      itemBuilder: (context, index) {
                        PeopleModel model = peopleList[index];
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: MyColorName.colorBg1,
                          contentPadding: EdgeInsets.all(10),
                          leading: InkWell(
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
                          title: text(getString(model.name.toString()), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                          trailing: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                model.connectionStatus = true;
                              });
                              sendConnection(curUserId, model.userId, model);
                            },
                            child: Container(
                              width: getWidth(200),
                              height: getHeight(60),
                              decoration: boxDecoration(
                                bgColor: MyColorName.colorBg1,
                                radius: 30.sp,
                                color: MyColorName.primaryLite,
                              ),
                              child: Center(
                                child: !model.connectionStatus
                                    ? text("Connect",
                                        textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, isLongText: true, fontSize: 10.sp)
                                    : Container(
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(
                                          color: MyColorName.primaryLite,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(getString(model.skills.toString()), textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                              // Row(
                              //   children: [
                              //     Image.asset(
                              //       "images/mutual.png",
                              //       width: getWidth(30),
                              //       height: getHeight(30),
                              //     ),
                              //     text("7 Mutual connections", textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                              //   ],
                              // ),
                            ],
                          ),
                        );
                      })
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
