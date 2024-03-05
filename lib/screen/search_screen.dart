import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/api/api_controller_expo.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/search_response.dart';
import 'package:nerdmine/screen/profile_screen.dart';
import 'package:nerdmine/screen/user_info_screen.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/flutter_toast.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController industryContr = TextEditingController();
  List<UserList> listOfUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
          title: text("Search".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
          actions: [],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              boxHeight(54),
              TextField(
                controller: industryContr,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                  ),
                  fillColor: MyColorName.colorBg1,
                  filled: true,
                  counterText: '',
                  contentPadding: EdgeInsets.all(getWidth(30)),
                  hintText: "Search here ...",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                  ),
                ),
                onChanged: (s) {
                  searchApi(s);
                },
              ),
              boxHeight(54),
              Expanded(
                child: ListView(
                  children: listOfUser
                      .map((e) => InkWell(
                            onTap: () {
                              String userId =  App.localStorage.getString("user_id") ?? "";
                              if (userId == e.userId) {
                                navigateScreen(context, ProfileScreen());
                              } else {
                                navigateScreen(context, UserProfileScreen(e.userId ?? ""));
                              }
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: commonImage(e.profileImage, 100.0, 100.0, "", context, "images/name.png")),
                              title: text(getString(e.name.toString()), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(e.userType ?? "", textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                  /*     Row(
                            children: [
                              Image.asset("images/mutual.png",width: getWidth(30),height: getHeight(30),),
                              text(" 7 Mutual connections",textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                            ],
                          ),*/
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> searchApi(String keyword) async {
    // // remove input focus
    // FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Map<String, dynamic> body = {"search_keyword": keyword};

    var formData = FormData.fromMap(body);

    SearchResponse response = await apiController.post<SearchResponse>("https://developmentalphawizz.com/Nerdmine/webService/searchUser/${curUserId}", body: formData);

    listOfUser.clear();
    if (response.status ?? false) {
      listOfUser.addAll(response.userList ?? []);
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }

    setState(() {});
  }
}
