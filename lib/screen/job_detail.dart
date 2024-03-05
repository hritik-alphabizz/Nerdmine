import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/job_model.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../utils/ApiBaseHelper.dart';
class JobDetailScreen extends StatefulWidget {
  String jobId;


  JobDetailScreen(this.jobId);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  bool obscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPageInfo();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

  getPageInfo() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + "jobDetails/${widget.jobId}/${curUserId}"));
    setState(() {
      loading = false;
    });
    if (response['status']) {
      var v = response['info'];
      jobDetailModel = JobDetailModel.fromJson(v);
    }
  }

  int length = 0;
  JobDetailModel? jobDetailModel;

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
            "Job search".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
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

      body: SingleChildScrollView(
        child: Container(
          child: jobDetailModel!=null?Column(
            children: [
              Container(
                decoration: boxDecoration(
                    radius: 10,
                    bgColor: MyColorName.colorBg1
                ),
                padding: EdgeInsets.all(getWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(getString(jobDetailModel!.jobTitle!),textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 14.sp),
                    boxHeight(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: commonImage(jobDetailModel!.companyLogo, 90.0, 90.0, "", context, "")),
                        boxWidth(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(getString(jobDetailModel!.companyName!),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 10.sp),
                              boxHeight(5),
                              text(getString(jobDetailModel!.location!),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 10.sp),
                              boxHeight(5),
                              ],
                          ),
                              ),
                            ],
                          ),
                          boxHeight(5),
                          Row(
                            children: [
                              Image.asset(
                                "images/blue_bag.png",
                                width: getWidth(30),
                                height: getHeight(30),
                              ),
                              boxWidth(10),
                              text("Post name : ", textColor: Color(0xff5e5e5e), fontFamily: fontRegular, fontSize: 10.sp),
                              Expanded(
                                  child: text(jobDetailModel!.position!,
                                      textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp))
                            ],
                          ),
                          boxHeight(30),
                          Row(
                            children: [
                              Image.asset(
                                "images/chair.png",
                                width: getWidth(30),
                                height: getHeight(30),
                              ),
                              boxWidth(10),
                              text("Total post : ", textColor: Color(0xff5e5e5e), fontFamily: fontRegular, fontSize: 10.sp),
                              Expanded(
                                  child: text(jobDetailModel!.noOfVacancy! + " Post",
                                      textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp))
                            ],
                          ),
                          boxHeight(30),
                          Row(
                            children: [
                              Image.asset(
                                "images/document.png",
                                width: getWidth(30),
                                height: getHeight(30),
                              ),
                              boxWidth(10),
                              text("Requirement : ", textColor: Color(0xff5e5e5e), fontFamily: fontRegular, fontSize: 10.sp),
                              Expanded(
                                  child: text(jobDetailModel!.educationRequired.toString(),
                                      textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp))
                            ],
                          ),
                          boxHeight(30),
                          Row(
                            children: [
                              Image.asset(
                                "images/calender.png",
                                width: getWidth(30),
                                height: getHeight(30),
                              ),
                              boxWidth(10),
                              text("Last date : ", textColor: Color(0xff5e5e5e), fontFamily: fontRegular, fontSize: 10.sp),
                              Expanded(
                                  child: text(jobDetailModel!.promotEndDate.toString(),
                                      textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp))
                            ],
                          ),
                          boxHeight(30),


                    App.localStorage.getString("user_type_id") == "6" || App.localStorage.getString("user_type_id") == "7" ? Container() : jobDetailModel?.applyJobStatus != "1"
                              ? InkWell(
                                  onTap: () {
                                    applyNow(jobDetailModel?.jobId ?? "", 0);
                                  },
                                  child: Container(
                                    width: getWidth(625),
                                    height: getHeight(90),
                                    decoration: boxDecoration(
                                      bgColor: MyColorName.primaryLite,
                                      radius: 48.sp,
                                    ),
                                    child: Center(
                                      child: !loading
                                          ? text("Apply Now",
                                              textColor: MyColorName.colorTextPrimary,
                                              fontFamily: fontRegular,
                                              isLongText: true,
                                              fontSize: 12.sp)
                                          : CircularProgressIndicator(
                                              color: MyColorName.colorTextPrimary,
                                            ),
                                    ),
                                  ),
                                )
                              : InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: getWidth(625),
                        height: getHeight(90),
                        decoration: boxDecoration(
                          bgColor: Colors.grey,
                          radius: 48.sp,
                        ),
                        child: Center(
                          child: !loading
                              ? text("Applied",
                              textColor: MyColorName.colorTextFour,
                              fontFamily: fontRegular,
                              isLongText: true,
                              fontSize: 12.sp)
                              : CircularProgressIndicator(
                            color: MyColorName.colorTextPrimary,
                          ),
                        ),
                      ),
                    ),
                          boxHeight(10),
                        ],
                      ),
                    ),
              boxHeight(30),
              Container(
                width: getWidth(720),
                  decoration: boxDecoration(
                      radius: 10,
                      bgColor: MyColorName.colorBg1
                  ),
                  padding: EdgeInsets.all(getWidth(30)),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      text("Location : ",textColor: Color(0xff5e5e5e),fontFamily: fontRegular,fontSize: 10.sp),
                      Expanded(child: text(jobDetailModel!.location.toString(),textColor: MyColorName.colorTextPrimary,fontFamily: fontRegular,fontSize: 10.sp))
                    ],
                  ),
                  verticalSpace(24.0),
                  text("Job Description",textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 10.sp),
                  boxHeight(10),
                  text(parseString(jobDetailModel!.jobsDescription.toString()),textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp,isLongText: true),
                ],
              )),
              boxHeight(30),
            ],
          ):Center(child: CircularProgressIndicator(color: MyColorName.primaryDark,),),
        ),
      ),
    );
  }

  TextEditingController passCon = new TextEditingController();
  TextEditingController oldCon = new TextEditingController();
  TextEditingController passConFirmCon = new TextEditingController();
  String? userType;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  likeFeed(id, index) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "item_id": id,
          "item_type":"1",
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "addItemInWishlist"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {

        } else {}
        String msg = response['msg'];
        setSnackbar(msg, context);
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

  applyNow(id, index) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "job_id": id,
        };
        Map response = await apiBase.postAPICall(Uri.parse(baseUrl + "userApplyOnJobs"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
        } else {}
        String msg = response['msg'];
        setSnackbar(msg, context);
        jobDetailModel?.applyJobStatus = "1";
        setState(() {});
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

  resetPass() async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id":curUserId,
          "old_password": oldCon.text,
          "new_password": passCon.text,
        };
        Map response = await apiBase.postAPICall(Uri.parse(baseUrl + "updatePassword"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          Navigator.pop(context);
        } else {
        }
        String msg = response['msg'];
        setSnackbar(msg, context);
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
