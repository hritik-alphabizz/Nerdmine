import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/sub_cat_model.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/screen/view_colleges_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../model/coach_model.dart';
import '../utils/constant.dart';

class ViewCourse extends StatefulWidget {
  CoachModel model;

  ViewCourse(this.model);

  @override
  State<ViewCourse> createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getCategory() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(
        baseUrl + "coursesListByCategoryId/${widget.model.categoryId}"));
    setState(() {
      loading = false;
    });
    if (response['status']) {
      for (var v in response['list']) {
        subCatList.add(SubCatModel.fromJson(v));
      }
      length = subCatList.length > 5 ? 5 : subCatList.length;
    }
  }

  int length = 0;
  List<SubCatModel> subCatList = [];
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
        title: text(widget.model.categoryTitle.toString(),
            textColor: MyColorName.primaryDark,
            fontFamily: fontMedium,
            fontSize: 14.sp),
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
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: MyColorName.colorBg1,
              padding: EdgeInsets.all(getWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text(
                      subCatList.length > 0
                          ? "Top ${length} ${widget.model.categoryTitle}"
                              .toString()
                          : "",
                      textColor: MyColorName.primaryDark,
                      fontFamily: fontMedium,
                      fontSize: 10.sp),
                  //  Image.asset("images/search.png",color: MyColorName.colorTextPrimary,width: getWidth(30),)
                ],
              ),
            ),
            boxHeight(30),
            !loading
                ? subCatList.length > 0
                    ? Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: getWidth(30)),
                          child: ListView.separated(
                              itemCount: length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return boxHeight(20);
                              },
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: (){
                                    String cId = subCatList[index].categoryId??"";
                                    String sId = subCatList[index].subCategoryId ??"";

                                    navigateScreen(context, ViewCollegeScreen(cId, sId));
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  tileColor: MyColorName.colorBg1,
                                  contentPadding: EdgeInsets.all(10),
                                  leading: commonImage(subCatList[index].image,
                                      50.0, 50.0, "", context, ""),
                                  title: text(
                                      subCatList[index].subCategoryTitle!,
                                      textColor: MyColorName.colorTextPrimary,
                                      fontFamily: fontMedium,
                                      fontSize: 10.sp),
                                );
                              }),
                        ),
                      )
                    : Center(
                        child: text("No Result Found",
                            textColor: MyColorName.primaryDark,
                            fontFamily: fontMedium,
                            fontSize: 10.sp),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            length != subCatList.length
                ? InkWell(
                    onTap: () {
                      setState(() {
                        length = subCatList.length;
                      });
                    },
                    child: Container(
                      width: getWidth(300),
                      height: getHeight(70),
                      decoration: boxDecoration(
                        bgColor: MyColorName.primaryLite,
                        radius: 48.sp,
                      ),
                      child: Center(
                        child: text("View all",
                            textColor: MyColorName.colorTextPrimary,
                            fontFamily: fontRegular,
                            isLongText: true,
                            fontSize: 12.sp),
                      ),
                    ),
                  )
                : SizedBox(),
            boxHeight(30),
          ],
        ),
      ),
    );
  }
}
