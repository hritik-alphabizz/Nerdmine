
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/job_detail.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';

import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../model/job_model.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({Key? key}) : super(key: key);

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  bool selected =false;
  List<JobModel> privateJob = [];
  List<JobModel> govtJob = [];
  List<JobModel> tempJob = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobs();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getJobs()async{


    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl+"jobList/${curUserId}"));
    if(response['status']){
      setState(() {
          loading = false;
      });
      for(var v in response['list']['private_job']){
        privateJob.add(JobModel.fromJson(v));
      }
      for(var v in response['list']['government_job']){
        govtJob.add(JobModel.fromJson(v));
      }
      tempJob = govtJob.toList();
    }
  }
  bool isNetwork = false;
  bool saved = false;
  savedJob(id) async {
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
        Map response = await apiBaseHelper.postAPICall(
            Uri.parse(baseUrl + "addItemInWishlist"), data);
        print(response);
        bool status = true;
        setState(() {
          saved = false;
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
         /* Container(
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(15)),
            child: Center(child: Image.asset("images/menu.png")),
          ),*/
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:getWidth(20)),
        child: Column(
          children: [
            boxHeight(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = false;
                        tempJob = govtJob.toList();
                      });
                    },
                    child: Container(
                      height: getHeight(90),
                      decoration: boxDecoration(
                        bgColor: MyColorName.colorBg1,
                        radius: 48.sp,
                        color: !selected?MyColorName.primaryLite:Color(0xff707070),
                      ),
                      child: Center(
                        child: text("Government job",
                            textColor: !selected?MyColorName.primaryLite:MyColorName.colorTextPrimary,
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
                      setState(() {
                        selected = true;
                        tempJob = privateJob.toList();
                      });
                    },
                    child: Container(
                      height: getHeight(90),
                      decoration: boxDecoration(
                        bgColor: MyColorName.colorBg1,
                        radius: 48.sp,
                        color: selected?MyColorName.primaryLite:Color(0xff707070),
                      ),
                      child: Center(
                        child: text("Private job",
                            textColor: selected?MyColorName.primaryLite:MyColorName.colorTextPrimary,
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
            Expanded(
              child: !loading?ListView.separated(
                  itemCount: tempJob.length,
                  shrinkWrap: true,
                  separatorBuilder: (context,index){
                    return boxHeight(20);
                  },
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        navigateScreen(context, JobDetailScreen(tempJob[index].jobId.toString()));
                      },
                      child: Container(
                        decoration: boxDecoration(
                          radius: 10,
                          bgColor: MyColorName.colorBg1
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: commonImage(tempJob[index].companyLogo, 136.0, 136.0, "", context, "")),
                            boxWidth(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(getString(tempJob[index].jobTitle!),textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp),
                                  boxHeight(5),
                                  text(getString(tempJob[index].companyName!),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                                  boxHeight(5),
                                  text(getString(tempJob[index].location!),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                                  boxHeight(5),
                                  /*    Row(
                                    children: [
                                      Image.asset("images/user.png",width: getWidth(30),height: getHeight(30),),
                                      boxWidth(5),
                                      text("Your profile match this job",textColor: Color(0xff5e5e5e),fontFamily: fontRegular,fontSize: 7.5.sp),
                                    ],
                                  ),*/
                                  boxHeight(10),
                                  text(getDuration(tempJob[index].createDate!),textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 7.sp),
                                ],
                              ),
                            ),
                            boxWidth(10),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    tempJob[index].addWishlistStatus="1";
                                  });
                                    savedJob(tempJob[index].jobId);
                                },
                                child: Image.asset("images/bookmark.png", height: getHeight(40),width: getHeight(30),fit: BoxFit.fill,color: tempJob[index].addWishlistStatus=="1"?Colors.red:Colors.grey,)),
                          ],
                        ),
                      ),
                    );
                  }):Center(child: CircularProgressIndicator(color: MyColorName.primaryDark,),),
            ),
          ],
        ),
      ),
    );
  }
}
