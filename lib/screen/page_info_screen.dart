

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/page_info_model.dart';
import 'package:nerdmine/model/page_model.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../utils/constant.dart';

class PageInfoScreen extends StatefulWidget {
  final String pageId;

  PageInfoScreen(this.pageId);

  @override
  State<PageInfoScreen> createState() => _PageInfoScreenState();
}

class _PageInfoScreenState extends State<PageInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPageInfo();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getPageInfo() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + "collegeOrInstituteInfo/${widget.pageId}"));
    setState(() {
      loading = false;
    });

    if (response['status']) {
      pageModel = PageInfoModel.fromJson(response);

    }
  }

  int length = 0;
  PageInfoModel? pageModel;
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
        title: text("${pageModel?.info?.pageName??""}", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
        actions: [
          Container(
            decoration: boxDecoration(
              bgColor: MyColorName.primaryDark,
              radius: 100,
            ),
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(15)),
            child: Center(child: Image.asset("images/notify.png")),
          ),
        ],
      ),
      body: Container(
        child: !loading
            ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  Container(
                    color: MyColorName.colorBg1,
                    padding: EdgeInsets.all(getWidth(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        text("${pageModel?.info?.pageName ?? ""}", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                        //  Image.asset("images/search.png",color: MyColorName.colorTextPrimary,width: getWidth(30),)
                      ],
                    ),
                  ),
                  commonImageWithoutHeightWidth(pageModel?.info?.coverPhoto,  "", context, ""),
                  boxHeight(30),
                  commonImageWithoutHeightWidth(pageModel?.info?.profileLogo,  "", context, ""),
                  boxHeight(30),
                  Container(
                    width: getWidth(650),
                    decoration: boxDecoration(
                      bgColor: Colors.white,
                      radius: 8,
                    ),
                    padding: EdgeInsets.all(getWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("About".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                        boxHeight(10),
                        Html(data: pageModel?.info?.aboutUs),
                        /* text(
                          "${ ??""}",
                          isLongText: true,
                          textColor: MyColorName.colorTextPrimary,
                          fontFamily: fontRegular,
                          fontSize: 10.sp,
                        ),*/
                      ],
                    ),
                  ),
                  boxHeight(30),
                  pageModel?.info?.serviceList != null && (pageModel?.info?.serviceList?.length ?? 0) > 0
                      ? Container(
                          width: getWidth(650),
                          decoration: boxDecoration(
                            bgColor: Colors.white,
                            radius: 8,
                          ),
                          padding: EdgeInsets.all(getWidth(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // text("Services".toString(),
                              //     textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                              boxHeight(10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
                                child: ListView.separated(
                                    itemCount: pageModel?.info?.serviceList?.length ?? 0,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: MyColorName.colorTextPrimary,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      ServiceList? model = pageModel?.info?.serviceList?[index];
                                      return ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          navigateScreen(context, PageInfoScreen(model?.tagPageId??""));
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        tileColor: MyColorName.colorBg1,
                                        contentPadding: EdgeInsets.all(10),
                                        leading: text("${index+1}", textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            text(
                                              "${model?.serviceTitle.toString()}",
                                              textColor: MyColorName.colorTextPrimary,
                                              fontFamily: fontMedium,
                                              fontSize: 10.sp,
                                            ),
                                          /*  text(
                                              "${model?.serviceDescription.toString()}",
                                              textColor: MyColorName.colorTextPrimary,
                                              fontFamily: fontMedium,
                                              fontSize: 10.sp,
                                            ),*/
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  boxHeight(30),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

/*


import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/page_info_model.dart';
import 'package:nerdmine/model/sub_cat_model.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../utils/constant.dart';

class PageInfoScreen extends StatefulWidget {
  SubCatModel model;

  PageInfoScreen(this.model);

  @override
  State<PageInfoScreen> createState() => _PageInfoScreenState();
}

class _PageInfoScreenState extends State<PageInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPageInfo();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getPageInfo() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(
        baseUrl + "collegeOrInstituteInfo/${widget.model.subCategoryId}"));
    setState(() {
      loading = false;
    });
    if (response['status']) {
      var v = response['info'];
      pageModel = PageModel.fromJson(v);
    }
  }

  int length = 0;
  PageModel? pageModel;
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
        title: text(widget.model.subCategoryTitle.toString(),
            textColor: MyColorName.primaryDark,
            fontFamily: fontMedium,
            fontSize: 10.sp),
        actions: [
          Container(
            decoration: boxDecoration(
              bgColor: MyColorName.primaryDark,
              radius: 100,
            ),
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(15)),
            child: Center(child: Image.asset("images/notify.png")),
          ),
        ],
      ),
      body: Container(
        child: !loading?Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: MyColorName.colorBg1,
              padding: EdgeInsets.all(getWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text(
                      "${pageModel?.pageName}",
                      textColor: MyColorName.primaryDark,
                      fontFamily: fontMedium,
                      fontSize: 10.sp),
                  //  Image.asset("images/search.png",color: MyColorName.colorTextPrimary,width: getWidth(30),)
                ],
              ),
            ),
            commonImage("${pageModel?.coverPhoto}", 200.0, 720.0, "", context, ""),
            boxHeight(30),
            Container(
              width: getWidth(650),
              decoration: boxDecoration(
                bgColor: Colors.white,
                radius: 8,
              ),
              padding: EdgeInsets.all(getWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                      "About".toString(),
                      textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 12.sp
                  ),
                  boxHeight(10),
                  text(
                      parseString("${pageModel?.aboutUs.toString()}"),
                      textColor: MyColorName.colorTextPrimary,fontFamily: fontRegular,fontSize: 10.sp
                  ),
                ],
              ),
            ),
            boxHeight(30),
            Container(
              width: getWidth(650),
              decoration: boxDecoration(
                bgColor: Colors.white,
                radius: 8,
              ),
              padding: EdgeInsets.all(getWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                      "Website".toString(),
                      textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 12.sp
                  ),
                  boxHeight(10),
                  text(
                      parseString("${pageModel?.website.toString()}"),
                      textColor: MyColorName.primaryDark,fontFamily: fontRegular,fontSize: 10.sp,under: true
                  ),
                ],
              ),
            ),
            boxHeight(30),
            Container(
              width: getWidth(650),
              decoration: boxDecoration(
                bgColor: Colors.white,
                radius: 8,
              ),
              padding: EdgeInsets.all(getWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                      "City".toString(),
                      textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 12.sp
                  ),
                  boxHeight(10),
                  text(
                      parseString(pageModel?.city.toString()),
                      textColor: MyColorName.colorTextPrimary,fontFamily: fontRegular,fontSize: 10.sp,
                  ),
                ],
              ),
            ),
            boxHeight(30),
            pageModel?.serviceList!=null&&(pageModel?.serviceList?.length ?? 0) >0?Container(
              width: getWidth(650),
              decoration: boxDecoration(
                bgColor: Colors.white,
                radius: 8,
              ),
              padding: EdgeInsets.all(getWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(
                      "Services".toString(),
                      textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 12.sp
                  ),
                  boxHeight(10),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: getWidth(30)),
                    child: ListView.separated(
                        itemCount: pageModel?.serviceList?.length??0,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: MyColorName.colorTextPrimary,
                          );
                        },
                        itemBuilder: (context, index) {

                          ServiceList? model = pageModel?.serviceList?[index];
                          return ListTile(
                            onTap: (){

                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            tileColor: MyColorName.colorBg1,
                            contentPadding: EdgeInsets.all(10),
                            leading:  text(
                                "○",
                                textColor: MyColorName.colorTextPrimary,
                                fontFamily: fontMedium,
                                fontSize: 10.sp),
                            title: text(
                                "${model?.serviceTitle.toString()}",
                                textColor: MyColorName.colorTextPrimary,
                                fontFamily: fontMedium,
                                fontSize: 10.sp),
                          );
                        }),
                  ),
                ],
              ),
            ):SizedBox(),
            boxHeight(30),
          ],
        ):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}

























* */

/*

   boxHeight(30),
                  Container(
                    width: getWidth(650),
                    decoration: boxDecoration(
                      bgColor: Colors.white,
                      radius: 8,
                    ),
                    padding: EdgeInsets.all(getWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Eligibility".toString(),
                            textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                        boxHeight(10),
                        text("Must have bachelors degree in any field",
                            textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp),
                      ],
                    ),
                  ),
                  boxHeight(30),
                  Container(
                    width: getWidth(650),
                    decoration: boxDecoration(
                      bgColor: Colors.white,
                      radius: 8,
                    ),
                    padding: EdgeInsets.all(getWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Entrance Exam".toString(),
                            textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                        boxHeight(10),
                        text("CAT, MAT, XAT, CMAT, NMAT, ATMA",
                            textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp),
                      ],
                    ),
                  ),
                  boxHeight(30),
                  Container(
                    width: getWidth(650),
                    decoration: boxDecoration(
                      bgColor: Colors.white,
                      radius: 8,
                    ),
                    padding: EdgeInsets.all(getWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Duration".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                        boxHeight(10),
                        text("2 years", textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp),
                      ],
                    ),
                  ),
                  boxHeight(30),
                  Container(
                    width: getWidth(650),
                    decoration: boxDecoration(
                      bgColor: Colors.white,
                      radius: 8,
                    ),
                    padding: EdgeInsets.all(getWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Top colleges providing that courses".toString(),
                            textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                        boxHeight(10),
                        ...["IIM", "VPS Mumbai", "DKLAS Banglore"]
                            .map((e) => Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    children: [
                                      horizontalSpace(20.0),
                                      placeHolderX(10.0, 10.0),
                                      horizontalSpace(10.0),
                                      text(
                                        e,
                                        textColor: MyColorName.colorTextPrimary,
                                        fontFamily: fontRegular,
                                        fontSize: 10.sp,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),






* */
