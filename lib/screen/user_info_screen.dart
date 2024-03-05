import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/job_model.dart';
import 'package:nerdmine/model/user_info_response.dart';
import 'package:nerdmine/res/AppColors.dart';
import 'package:nerdmine/screen/chat_page.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../utils/ApiBaseHelper.dart';

class UserProfileScreen extends StatefulWidget {
  final String profileId;

  UserProfileScreen(this.profileId);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool obscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileDetail(widget.profileId);
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool chatLoading = false;

  callChat(String? name, fcid, profileImage, userId, email) async {
    await App.init();

    var otherUser1 = types.User(
      firstName: name,
      id: fcid,
      imageUrl: profileImage,
      lastName: "",
    );
    _handlePressed(otherUser1, context, fcid, userId, name, email);
  }

  _handlePressed(types.User otherUser, BuildContext context, String fcmID, userId, name, email) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    setState(() {
      chatLoading = false;
    });
    addChat(userId, room.id);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          name: name,
          email: email,
          room: room,
          fcm: fcmID,
        ),
      ),
    );
  }

  addChat(id, roomID) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "chat_with_user_id": id,
          "chat_room_id": roomID,
        };
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "initiateChat"), data);
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

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

  /*getPageInfo() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + "jobDetails/${widget.jobId}/${curUserId}"));
    setState(() {
      loading = false;
    });
    if (response['status']) {
      var v = response['info'];
      jobDetailModel = JobDetailModel.fromJson(v);
    }
  }*/

  int length = 0;
  JobDetailModel? jobDetailModel;
  UserInfoResponse? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F8),
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
                Assets.imagesBack,
                fit: BoxFit.fill,
              )),
        ),
        backgroundColor: Color(0xffF2F4F8),
        elevation: 1,
        title: text("${response?.userInfo?.name ?? ""}".toString(),
            overFlow: true, maxLine: 1, textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
        actions: [
          InkWell(
            onTap: () {
              navigateScreen(context, SearchScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/search.png")),
            ),
          ),
          /*  Container(
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(15)),
            child: Center(child: Image.asset("images/menu.png")),
          ),*/
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // background image and bottom contents
                      Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesIcCompany), fit: BoxFit.fill)),
                            ),
                          ),
                          Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  boxHeight(100),
                                  Wrap(
                                    children: [
                                      text('${response?.userInfo?.name}', textColor: Color(0xFF13484E), fontFamily: fontBold, fontSize: 12.sp),
                                      text(' | ${response?.userInfo?.email} ', textColor: Color(0xFF9F9F9F), fontFamily: fontMedium, fontSize: 12.sp, maxLine: 1),
                                    ],
                                  ),
                                  boxHeight(10),
                                  text("${response?.userInfo?.profileTitle ?? ""}",
                                      textColor: Color(0xFF13484E), fontFamily: fontMedium, fontSize: 12.sp),
                                  boxHeight(10),
                                  text("${response?.userInfo?.location ?? ""}",
                                      textColor: Color(0xFF13484E), fontFamily: fontMedium, fontSize: 12.sp),
                                  boxHeight(10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      text("${response?.userInfo?.totalFollowing}",
                                          textColor: Color(0xFF13484E), fontFamily: fontMedium, fontSize: 12.sp),
                                      boxWidth(5),
                                      text('Followers', textColor: Color(0xFF9F9F9F), fontFamily: fontMedium, fontSize: 12.sp),
                                      boxWidth(5),
                                      text('${response?.userInfo?.totalConnection}',
                                          textColor: Color(0xFF13484E), fontFamily: fontMedium, fontSize: 12.sp),
                                      boxWidth(5),
                                      text('Connections', textColor: Color(0xFF9F9F9F), fontFamily: fontMedium, fontSize: 12.sp),
                                    ],
                                  ),
                                  boxHeight(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (response?.userInfo?.connectedStatus == "0")
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              sendConnection(App.localStorage.getString("user_id"), response?.userInfo?.userId ?? "");
                                            },
                                            child: Container(
                                              height: getHeight(70),
                                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                                              decoration: boxDecoration(
                                                bgColor: Color(0xFFFCAA47),
                                                radius: 48.sp,
                                                color: Color(0xff707070),
                                              ),
                                              child: Center(
                                                child: text("Connect",
                                                    textColor: MyColorName.colorTextPrimary,
                                                    fontFamily: fontRegular,
                                                    isLongText: true,
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      boxWidth(20),
                                      if (response?.userInfo?.connectedStatus == "1")
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              callChat(response?.userInfo?.name, response?.userInfo?.fcid, response?.userInfo?.profileImage,
                                                  response?.userInfo?.userId, response?.userInfo?.email);
                                            },
                                            child: Container(
                                              height: getHeight(70),
                                              decoration: boxDecoration(
                                                bgColor: MyColorName.colorBg1,
                                                radius: 48.sp,
                                                color: Color(0xff707070),
                                              ),
                                              child: Center(
                                                child: text("Message",
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
                                ],
                              ))
                        ],
                      ),

                      Positioned(
                          right: 20,
                          left: 20,
                          top: 180, // (background container size) - (circle height / 2)
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: commonImage(response?.userInfo?.profileImagePath, 120.0, 120.0, "", context, "")),
                              ),
                              InkWell(
                                onTap: () {
                                  showUserProfileOptions();
                                },
                                child: Image.asset("images/menu.png", height: getHeight(45)),
                              ),
                            ],
                          ))
                    ],
                  ),

                  Container(
                    height: 20,
                    color: Color(0xFFF2F4F8),
                  ),
                  if (response?.userInfo?.aboutUs?.isEmpty ?? false)
                    Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          text('About  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                          boxHeight(20),
                          text('${response?.userInfo?.aboutUs ?? ""}', textColor: AppColors.textColor, fontFamily: fontRegular, fontSize: 10.sp),
                        ],
                      ),
                    ),

                  Container(
                    height: 20,
                    color: Color(0xFFF2F4F8),
                  ),
                  if (response?.userInfo?.experienceInfo?.isNotEmpty ?? false)
                    Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          text('Experience  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                          boxHeight(20),
                          ...listOfExperience.map((e) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(Assets.imagesBlueBag, height: getHeight(50)),
                                    boxWidth(20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          text('${e.companyName}', textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                                          boxHeight(10),
                                          text('${e.positionInCompany}  ', textColor: AppColors.black, fontFamily: fontBold, fontSize: 10.sp),
                                          boxHeight(5),
                                          Row(
                                            children: [
                                              text('Feb 2021- Present  ', textColor: Color(0xFFB7B7B7), fontFamily: fontRegular, fontSize: 8.sp),
                                              text(' | 1 year 5 mos  ', textColor: AppColors.black, fontFamily: fontRegular, fontSize: 8.sp),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  Container(
                    height: 20,
                    color: Color(0xFFF2F4F8),
                  ),
                  if (response?.userInfo?.educationInfo?.isNotEmpty ?? false)
                    Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          text('Education  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                          boxHeight(20),
                          ...listOfEducation.map((e) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(Assets.imagesEducation, width: 45.0,),
                                    boxWidth(20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          text("${e.instituteName}", textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                                          boxHeight(10),
                                          text('${e.coursesName}', textColor: AppColors.black, fontFamily: fontBold, fontSize: 10.sp),
                                        boxHeight(5),
                                        text('${e.startDate} - ${e.endDate}', textColor: AppColors.black, fontFamily: fontBold, fontSize: 10.sp),
                                        boxHeight(5),
                                      ],
                                    ),
                                  )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  Container(
                    height: 20,
                    color: Color(0xFFF2F4F8),
                  ),
                  if (response?.userInfo?.skills?.isNotEmpty ?? false)
                    Container(
                      color: AppColors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          text('Skills  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                          boxHeight(20),
                          ...skills.map(
                            (e) => text(e, textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),

                  // boxHeight(30),
                ],
              )),
            ),
    );
  }

  List<String> skills = [];
  List<ExperienceInfo> listOfExperience = [];
  List<EducationInfo> listOfEducation = [];

  Future<void> getProfileDetail(String profileId) async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Map<String, dynamic> body = {"user_id": App.localStorage.getString("user_id"), "view_info_user_id": profileId};
    print(body);
    var formData = FormData.fromMap(body);

    loading = true;
    setState(() {});
    response = await apiController.post<UserInfoResponse>(EndPoints.VIEW_USER_PROFILE, body: formData);
    loading = false;

    //hide loader
    skills.clear();
    if (response?.status ?? false) {
      response?.userInfo?.skillsList?.forEach((e) {
        skills.add(e.skillTitle ?? "");
      });

      listOfEducation.addAll(response?.userInfo?.educationInfo ?? []);
      listOfExperience.addAll(response?.userInfo?.experienceInfo ?? []);
      //Update UI
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
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
                  ...["Share via message", "Follow ${jobDetailModel?.userName ?? ""}", "Report or Block"].map((e) => InkWell(
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

  bool isNetwork = false;

  sendConnection(sendId, receiveId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {"sender_user_id": sendId, "receiver_user_id": receiveId};
        Dialogs.showLoader(context, "Sending connection request");
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "sendConnectionRequest"), data);
        Dialogs.hideLoader(context);
        // Decode the JSON response string
        dynamic decodedJson = json.decode(json.encode(response));
        // Convert the decoded JSON object to a formatted JSON string
        String formattedJson = JsonEncoder.withIndent('    ').convert(decodedJson);
        print(formattedJson);
        bool status = true;
        setState(() {
          // connectionStatus = false;
        });
        if (response['status']) {
          FlutterToastX.showSuccessToastBottom(context, "Connection request sent");
          getProfileDetail(widget.profileId);
          setState(() {
            // connectionList = [];
            // requestList = [];
            // peopleList = [];
          });
          // getConnection();
        } else {
          FlutterToastX.showErrorToastBottom(context, "Already sent connection request");
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
}
