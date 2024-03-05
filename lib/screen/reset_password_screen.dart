import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/screen/home_screen.dart';
import 'package:nerdmine/screen/intro_slider.dart';
import 'package:nerdmine/screen/welcome_screen.dart';
import 'package:nerdmine/utils/Session.dart';

import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';


import 'package:sizer/sizer.dart';

import '../utils/ApiBaseHelper.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool obscure = true;
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
            "Change password".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(47)),
          child: Column(
            children: [
              boxHeight(47),
              TextField(
                keyboardType: TextInputType.text,
                controller: oldCon,
                obscureText: obscure,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                  ),
                  fillColor: MyColorName.colorBg1,
                  filled: true,
                  counterText: '',
                  suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        obscure=!obscure;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(Assets.imagesPassword,
                        height: getWidth(29),
                        width: getWidth(29), fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(getWidth(30)),
                  hintText: "Enter Your Old Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                  ),
                ),
              ),
              boxHeight(47),
              TextField(
                keyboardType: TextInputType.text,
                controller: passCon,
                obscureText: obscure,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                  ),
                  fillColor: MyColorName.colorBg1,
                  filled: true,
                  counterText: '',
                  suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        obscure=!obscure;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(Assets.imagesPassword,
                        height: getWidth(29),
                        width: getWidth(29), fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(getWidth(30)),
                  hintText: "Enter New Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                  ),
                ),
              ),
              boxHeight(10),
              text(
                  "Your New Password must be Different From Your Previous Passwords.".toString(),
                  textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 10.sp
              ),
              boxHeight(37),
              TextField(
                controller: passConFirmCon,
                obscureText: obscure,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                  ),
                  fillColor: MyColorName.colorBg1,
                  filled: true,
                  contentPadding: EdgeInsets.all(getWidth(30)),
                  counterText: '',
                  suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        obscure=!obscure;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(Assets.imagesPassword,
                        height: getWidth(29),
                        width: getWidth(40), fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  hintText: "Confirm New Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                  ),
                ),
              ),
              boxHeight(47),
              boxHeight(50),
              InkWell(
                onTap: (){
                  if(oldCon.text==""||oldCon.text.length<6){
                    setSnackbar("Please enter valid  old password", context);
                    return;
                  }
                  if(passCon.text==""||passCon.text.length<6){
                    setSnackbar("Please enter valid password", context);
                    return;
                  }
                  if(passCon.text!=passConFirmCon.text){
                    setSnackbar("Both Password doesn't match", context);
                    return;
                  }
                  setState(() {
                    loading = true;
                  });
                  resetPass();
                },
                child: Container(
                  width: getWidth(625),
                  height: getHeight(90),
                  decoration: boxDecoration(
                    bgColor: MyColorName.primaryLite,
                    radius: 48.sp,
                  ),
                  child: Center(
                    child: !loading?text("Save",
                        textColor: MyColorName.colorTextPrimary,
                        fontFamily: fontRegular,
                        isLongText: true,
                        fontSize: 12.sp):CircularProgressIndicator(color: MyColorName.colorTextPrimary,),
                  ),
                ),
              ),
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
  bool isNetwork = false;
  bool loading = false;
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
