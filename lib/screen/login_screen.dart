import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/forget_scrren.dart';
import 'package:nerdmine/screen/otp_screen.dart';
import 'package:nerdmine/screen/register_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePage();
  }

  changePage() async {

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: getWidth(720),
            decoration: BoxDecoration(
                color: MyColorName.colorBg2
            ),
            padding: EdgeInsets.symmetric(horizontal: getWidth(47)),
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boxHeight(30),
                Container(
                    child: Image.asset(
                      Assets.imagesLoginLogo,
                      height: getHeight(113),
                      width: getWidth(314), fit: BoxFit.fill,
                    )),
                boxHeight(76),
                text("Login",
                    textColor: MyColorName.colorTextThird,
                    fontFamily: fontBold,
                    isLongText: true,
                    fontSize: 20.sp),
                boxHeight(46),
                text("Login with your mobile number or continue with social media",
                    textColor: MyColorName.appbarBg,
                    fontFamily: fontRegular,
                    isCentered: true,
                    isLongText: true,
                    fontSize: 14.sp),
                boxHeight(46),
                TextField(
                  controller: phoneCon,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(Assets.imagesPhone,
                        height: getWidth(29),
                        width: getWidth(29), fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    hintText: "Enter mobile no.",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                    ),
                  ),
                ),
                boxHeight(54),
                TextField(
                  controller: passCon,
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
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            obscure=!obscure;
                          });
                        },
                        child: Image.asset(Assets.imagesPass,
                          height: getWidth(29),
                          width: getWidth(40), fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    hintText: "Enter password",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                    ),
                  ),
                ),
                boxHeight(21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        navigateScreen(context, ForgetScreen());
                      },
                      child: text(
                        "Forgot password",
                        textColor: MyColorName.primaryLite,
                        fontFamily: fontMedium,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                boxHeight(37),
                InkWell(
                  onTap: (){
                    if(phoneCon.text==""){
                      setSnackbar("Please enter valid phone number", context);
                      return;
                    }
                    if(passCon.text==""||passCon.text.length<6){
                      setSnackbar("Please enter valid password", context);
                      return;
                    }
                    setState(() {
                      loading = true;
                    });
                    loginUser();
                  },
                  child: Container(
                    width: getWidth(625),
                    height: getHeight(90),
                    decoration: boxDecoration(
                      bgColor: MyColorName.primaryLite,
                      radius: 48.sp,
                    ),
                    child: Center(
                      child: !loading?text("Login",
                          textColor: MyColorName.colorTextPrimary,
                          fontFamily: fontRegular,
                          isLongText: true,
                          fontSize: 12.sp):CircularProgressIndicator(color: MyColorName.colorTextPrimary,),
                    ),
                  ),
                ),
                boxHeight(63),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: getWidth(100),
                        child: Divider(
                          thickness: 1,
                        )),
                    text(
                      "  Or Login with  ",
                      textColor: MyColorName.colorTextSecondary,
                      fontFamily: fontRegular,
                      fontSize: 10.sp,
                    ),
                    Container(
                        width: getWidth(100),
                        child: Divider(
                          thickness: 1,
                        )),
                  ],
                ),
                boxHeight(47),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesFb,
                      height: getWidth(86),
                      width: getWidth(86), fit: BoxFit.fill,
                    ),
                    boxWidth(67),
                    Image.asset(
                      Assets.imagesGoogle,
                      height: getWidth(86),
                      width: getWidth(86), fit: BoxFit.fill,
                    ),
                  ],
                ),
                boxHeight(63),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(
                      "Don’t have an account? ",
                      textColor: MyColorName.colorTextPrimary,
                      fontFamily: fontMedium,
                      fontSize: 10.sp,
                    ),
                    InkWell(
                      onTap: (){
                        navigateScreen(context, RegisterScreen());
                      },
                      child: text(
                        "Register Now",
                        textColor: MyColorName.primaryLite,
                        fontFamily: fontMedium,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                boxHeight(63),
              ],
            ),
          ),
        ),
      ),
    );
  }
  TextEditingController phoneCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  loginUser() async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"


    if (isNetwork) {
      try {
        Map data;
        data = {
          "phone_no": phoneCon.text.trim().toString(),
          "password":passCon.text.toString(),
        };
        Map response = await apiBase.postAPICall(Uri.parse(baseUrl + "login"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          App.localStorage.setString("user_id", response['UserInfo']['user_id']);
          App.localStorage.setString("name", response['UserInfo']['name']);
          App.localStorage.setString("email", response['UserInfo']['email']);
          App.localStorage.setString("user_type", response['UserInfo']['user_type']);
          App.localStorage.setString("user_type_id", response['UserInfo']['user_type_id']);
          App.localStorage.setString("profile", response['UserInfo']['profile_image_path']);
          App.localStorage.setString("user_unique_id", response['UserInfo']['user_unique_id']);
          curUserId = App.localStorage.getString("user_id");

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen("", response['OTP'].toString(), ""))).then((value) {
            Navigator.of(context).pop();
          });

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