import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/connection_model.dart';
import 'package:nerdmine/model/notification_response.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen();

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationList> listOfNotifications = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getNotificationList();
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
                Assets.imagesBack,
                fit: BoxFit.fill,
              )),
        ),
        backgroundColor: Color(0xffF2F4F8),
        elevation: 1,
        title: text("Notifications".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
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
                    text("${listOfNotifications.length ?? 0} Notifications".toString(),
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
               listOfNotifications.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
                      child: ListView.separated(
                          itemCount:listOfNotifications.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return boxHeight(20);
                          },
                          itemBuilder: (context, index) {
                            NotificationList model = listOfNotifications[index];
                            return ListTile(
                              onTap: () {
                                // callChat(model);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              tileColor: MyColorName.colorBg1,
                              contentPadding: EdgeInsets.all(10),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100), child: commonImage(model.profileImagePath, 100.0, 100.0, "", context, "")),
                              title: text(getString(model.name.toString()),
                                  textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                              // trailing: InkWell(
                              //   onTap: () {
                              //     // showUserProfileOptions();
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
                                  text(model.notificationTitle??"", textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                  text(model.notificationTime??"", textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
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

  Future<void> getNotificationList() async {
    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    String? userId = App.localStorage.getString("user_id");

    Dialogs.showLoader(context, "Getting Notifications ...");
    NotificationResponse response = await apiController.get<NotificationResponse>("${EndPoints.NOTIFICATION_LIST}/${userId??""}");


    //hide loader
    await Dialogs.hideLoader(context);
    if (response.status ?? false) {
      listOfNotifications.clear();
      listOfNotifications.addAll(response.list ?? []);
      //Update UI
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }
    setState(() {});
  }
}
