import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/home_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  String id, otp, type;

  OtpScreen(this.id, this.otp, this.type);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: getWidth(120),
      height: getWidth(120),
      textStyle: TextStyle(fontSize: 20, color: MyColorName.appbarBg, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: MyColorName.colorTextPrimary),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            elevation: 0,
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
            backgroundColor: Colors.white,
            actions: [
/*              Container(
                decoration: boxDecoration(
                  bgColor: MyColorName.primaryDark,
                  radius: 100,
                ),
                margin: EdgeInsets.all(getWidth(10)),
                padding: EdgeInsets.all(getHeight(15)),
                child: Center(child: Image.asset("images/notify.png")),*/
              // ),
            ],
            title: text('Otp',
                textColor: MyColorName.primaryDark,
                fontFamily: fontMedium,
                fontSize: 14.sp)),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: getWidth(21), right: getWidth(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boxHeight(20),
              text("Enter OTP Code", fontWeight: FontWeight.w700, fontFamily: fontBold, fontSize: 20.sp, textColor: MyColorName.primaryDark),
              boxHeight(13),
              text("Enter the OTP sent on your registered phone number.",
                  fontWeight: FontWeight.w500, fontFamily: fontRegular, fontSize: 10.sp, textColor: Color(0xff474747)),
              boxHeight(50),
              Center(
                child: Pinput(
                  controller: pinCon,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (s) {
                    return s == widget.otp ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
              ),
              boxHeight(50),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text("Not received code? ",
                      fontWeight: FontWeight.w400, fontFamily: fontRegular, fontSize: 10.sp, textColor: MyColorName.colorTextPrimary),
                  boxWidth(5),
                  InkWell(
                    onTap: () {},
                    child: text("Resend", fontWeight: FontWeight.w500, fontFamily: fontRegular, fontSize: 10.sp, textColor: MyColorName.primaryLite),
                  ),
                ],
              ),*/
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade800, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999))),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (widget.otp == pinCon.text.toString()) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HomeScreen())).then((value) {
                          Navigator.of(context).pop();
                        });

                      } else {
                        FlutterToastX.showErrorToastBottom(context, "Please enter correct otp");
                      }


                      // saveSkills();
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
              ),

              boxHeight(31),
            ],
          ),
        ),
      ),
    );
  }

  bool loading = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();

  loginApi() async {
    await App.init();
    Map param = {};
    if (widget.type == "forget") {
      param = {
        "user_id": widget.id,
        "forgot_otp": pinCon.text,
      };
    } else {
      param = {
        "id": widget.id,
        "otp": pinCon.text,
      };
    }
    Map response = await apiBaseHelper.postAPICall(
        Uri.parse(widget.type == "forget" ? baseUrl + "verify-forgot-otp" : baseUrl + "otp-verification"), jsonEncode(param));
    print(response);
    setState(() {
      loading = false;
    });
    if (response['status'] == "success") {
      print(App.localStorage.getString("token"));
      if (widget.type == "forget") {
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResetPassword(widget.id)), (route) => false);
      } else {
        App.localStorage.setString("user_id", widget.id);
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
      }

      return;
    } else {
      // setSnackbar(response['message'], context);
    }
  }
}
