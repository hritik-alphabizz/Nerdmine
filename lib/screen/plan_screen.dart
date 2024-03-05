import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/model/plan_model.dart';
import 'package:nerdmine/screen/home_screen.dart';
import 'package:nerdmine/screen/intro_slider.dart';
import 'package:nerdmine/screen/welcome_screen.dart';
import 'package:nerdmine/utils/Razorpay.dart';
import 'package:nerdmine/utils/Session.dart';

import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';


import 'package:sizer/sizer.dart';

import '../utils/ApiBaseHelper.dart';
class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  bool obscure = true;
  bool selected =false;

  List<PlanModel> planList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlan();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getPlan()async{
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl+"subscriptionPlanList/${curUserId}"));
    if(response['status']){
      setState(() {
        loading = false;
      });
      for(var v in response['list']){
        planList.add(PlanModel.fromJson(v));
      }
    }
  }
  bool isNetwork = false;
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
            "Premium Plans".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(47)),
          child: Column(
            children: [
              boxHeight(30),
              text(
                  "Join our premium plan and get ahead".toString(),
                  textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 18.sp
              ),
              boxHeight(50),
              !loading?ListView.builder
                (
                itemCount: planList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                  PlanModel model = planList[index];
                return  Container(
                  margin: EdgeInsets.only(bottom: getHeight(20)),
                  padding: EdgeInsets.only(top: getHeight(20)),
                  decoration: boxDecoration(
                    radius: 10,
                    bgColor: MyColorName.primaryLite,
                  ),
                  child: Container(
                    width: getWidth(650),
                    decoration: boxDecoration(
                      radius: 10,
                      bgColor: MyColorName.colorBg1,
                    ),
                    padding: EdgeInsets.all(getWidth(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                            model.subscriptionTitle.toString(),
                            textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 14.sp
                        ),
                        text(
                            model.subscriptionType.toString().toString(),
                            textColor: MyColorName.colorTextSecondary,fontFamily: fontMedium,fontSize: 10.sp
                        ),
                        boxHeight(10),
                        Divider(
                          thickness: 2,
                        ),
                        boxHeight(10),
                        /*text(
                            "Benefits you get".toString(),
                            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 10.sp
                        ),
                        boxHeight(10),*/
                        text(
                            model.subscriptionDescription.toString(),
                            textColor: MyColorName.colorTextSecondary,fontFamily: fontMedium,fontSize: 10.sp,isLongText: true
                        ),
                        boxHeight(50),
                        InkWell(
                          onTap: (){
                            RazorPayHelper razorPay = new RazorPayHelper(model.subscriptionPrice.toString(), context, (value) {
                              setState(() {
                                loading = false;
                              });
                            });
                            setState(() {
                              loading = true;
                            });
                            razorPay.init();
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(90),
                            decoration: boxDecoration(
                              bgColor: MyColorName.primaryDark,
                              radius: 48.sp,
                            ),
                            child: Center(
                              child: !loading?text("₹${model.subscriptionPrice}/${model.subscriptionType}",
                                  textColor: MyColorName.colorBg1,
                                  fontFamily: fontRegular,
                                  isLongText: true,
                                  fontSize: 12.sp):CircularProgressIndicator(color: MyColorName.colorTextPrimary,),
                            ),
                          ),
                        ),
                       /* boxHeight(40),
                        InkWell(
                          onTap: (){
                              RazorPayHelper razorPay = new RazorPayHelper("1000", context, (value) {
                                setState(() {
                                  loading = false;
                                });
                              });
                            setState(() {
                              loading = true;
                            });
                            razorPay.init();
                          },
                          child: Container(
                            width: getWidth(625),
                            height: getHeight(90),
                            decoration: boxDecoration(
                              color: MyColorName.primaryDark,
                              radius: 48.sp,
                            ),
                            child: Center(
                              child: !loading?text("Yearly",
                                  textColor: MyColorName.primaryDark,
                                  fontFamily: fontRegular,
                                  isLongText: true,
                                  fontSize: 12.sp):CircularProgressIndicator(color: MyColorName.colorTextPrimary,),
                            ),
                          ),
                        ),*/
                        boxHeight(10),
                      ],
                    ),
                  ),
                );
              }):Center(child: CircularProgressIndicator(color: MyColorName.primaryDark,),),


              boxHeight(93),
            ],
          ),
        ),
      ),
    );
  }
  TextEditingController passCon = new TextEditingController();
  TextEditingController oldCon = new TextEditingController();
  TextEditingController passConFirmCon = new TextEditingController();
  String? userType;
  ApiBaseHelper apiBase = new ApiBaseHelper();
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
