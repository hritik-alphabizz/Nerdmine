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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    changePage();
  }

  List<RegisterModel> regList = [];
  getData() async {
    Map response =
        await apiBase.getAPICall(Uri.parse(baseUrl + "registrationFromData"));
    if (response['status']) {
      for (var v in response['user_type']) {
        setState(() {
          regList.add(RegisterModel.fromJson(v));
        });
      }
    }
  }

  changePage() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: getWidth(720),
            decoration: BoxDecoration(color: MyColorName.colorBg2),
            padding: EdgeInsets.symmetric(horizontal: getWidth(47)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boxHeight(30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        back(context);
                      },
                      child: Container(
                          decoration: boxDecoration(
                            bgColor: MyColorName.colorTextThird,
                            radius: 5.sp,
                          ),
                          height: getWidth(72),
                          width: getWidth(72),
                          padding: EdgeInsets.all(getWidth(20)),
                          child: Image.asset(
                            Assets.imagesBack,
                            fit: BoxFit.fill,
                          )),
                    ),
                    boxWidth(83),
                    Container(
                        child: Image.asset(
                      Assets.imagesLoginLogo,
                      height: getHeight(113),
                      width: getWidth(314),
                      fit: BoxFit.fill,
                    )),
                  ],
                ),
                boxHeight(76),
                text("Sign Up",
                    textColor: MyColorName.colorTextThird,
                    fontFamily: fontBold,
                    isLongText: true,
                    fontSize: 20.sp),
                boxHeight(59),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(25), vertical: getHeight(6)),
                  decoration: boxDecoration(
                      bgColor: MyColorName.colorBg1,
                      radius: 30,
                      color: Colors.grey.withOpacity(0.3)),
                  child: DropdownButton2(
                      value: userType,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          userType = value.toString();
                        });
                      },
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: getWidth(625),
                        maxHeight: 200,
                      ),
                      underline: SizedBox(),
                      hint: text("Select profession",
                          textColor: Colors.black.withOpacity(0.7)),
                      items: regList.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.userTypeId,
                          child: text(e.userType!, textColor: Colors.black),
                        );
                      }).toList()),
                ),
                /* TextField(
                  keyboardType: TextInputType.text,
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
                    hintText: "Select profession",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                    ),
                  ),
                ),*/
                boxHeight(47),
                TextField(
                  controller: nameCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(
                        Assets.imagesName,
                        height: getWidth(29),
                        width: getWidth(29),
                        fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    hintText: "Full name",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                  ),
                ),
                boxHeight(47),
                TextField(
                  controller: phoneCon,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(
                        Assets.imagesPhone,
                        height: getWidth(29),
                        width: getWidth(29),
                        fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    hintText: "Enter mobile number",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                  ),
                ),
                boxHeight(47),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCon,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(
                        Assets.imagesMail,
                        height: getWidth(29),
                        width: getWidth(29),
                        fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    hintText: "Enter email id",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                  ),
                ),
                boxHeight(47),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: passCon,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(
                        Assets.imagesPassword,
                        height: getWidth(29),
                        width: getWidth(29),
                        fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                  ),
                ),
                boxHeight(47),
                TextField(
                  controller: passConFirmCon,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(
                        Assets.imagesPassword,
                        height: getWidth(29),
                        width: getWidth(40),
                        fit: BoxFit.fill,
                      ),
                    ),
                    hintText: "Confirm Password",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                  ),
                ),
                boxHeight(47),
                TextField(
                  controller: referCon,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                    fillColor: MyColorName.colorBg1,
                    filled: true,
                    contentPadding: EdgeInsets.all(getWidth(30)),
                    counterText: '',
                    suffixIcon: Container(
                      padding: EdgeInsets.all(getWidth(20)),
                      child: Image.asset(
                        Assets.imagesRefer,
                        height: getWidth(29),
                        width: getWidth(40),
                        fit: BoxFit.fill,
                      ),
                    ),
                    hintText: "Enter referral code",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(48.sp),
                      borderSide: BorderSide(
                          color:
                              MyColorName.colorTextSecondary.withOpacity(0.2)),
                    ),
                  ),
                ),
                boxHeight(104),
                InkWell(
                  onTap: () {
                    if (userType == null) {
                      setSnackbar("Select Profession", context);
                      return;
                    }
                    if (nameCon.text == "") {
                      setSnackbar("Please enter name", context);
                      return;
                    }
                    if (phoneCon.text == "" || phoneCon.text.length != 10) {
                      setSnackbar("Please enter valid phone number", context);
                      return;
                    }
                    if (validateEmail(emailCon.text, "", "") != null) {
                      setSnackbar("Please Enter Valid Email", context);
                      return;
                    }
                    if (passCon.text == "" || passCon.text.length < 6) {
                      setSnackbar("Please enter valid password", context);
                      return;
                    }
                    if (passCon.text != passConFirmCon.text) {
                      setSnackbar("Both Password doesn't match", context);
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
                      child: !loading
                          ? text("Signup",
                              textColor: MyColorName.colorTextPrimary,
                              fontFamily: fontRegular,
                              isLongText: true,
                              fontSize: 12.sp)
                          : CircularProgressIndicator(
                              color: MyColorName.colorTextPrimary,
                            ),
                    ),
                  ),
                ),
                boxHeight(93),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(
                      "Already have an account? ",
                      textColor: MyColorName.colorTextPrimary,
                      fontFamily: fontMedium,
                      fontSize: 10.sp,
                    ),
                    InkWell(
                      onTap: () {
                        back(context);
                      },
                      child: text(
                        "LogIn",
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

  TextEditingController nameCon = new TextEditingController();
  TextEditingController emailCon = new TextEditingController();
  TextEditingController phoneCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();
  TextEditingController referCon = new TextEditingController();
  TextEditingController passConFirmCon = new TextEditingController();
  String? userType;
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
          "user_type_id": userType,
          "name": nameCon.text,
          "email": emailCon.text,
          "phone_no": phoneCon.text.trim().toString(),
          "password": passCon.text.toString(),
          "referral_code": referCon.text,
        };
        if (referCon.text != "") {
          data['referral_code'] = referCon.text;
        }
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "userRegistration"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          Navigator.pop(context);
          //  navigateScreen(context, HomeScreen());
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
}
