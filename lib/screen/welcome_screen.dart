import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/intro_slider.dart';

import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';


import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            height: getHeight(1280),
            width: getWidth(720),
            decoration: BoxDecoration(
              color: MyColorName.colorBg2
            ),
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boxHeight(55),
                text("Welcome To",
                    textColor: MyColorName.colorTextThird,
                    fontFamily: fontBold,
                    isLongText: true,
                    fontSize: 20.sp),
                boxHeight(46),
                Container(
                    child: Image.asset(
                      Assets.imagesBlueLogo,
                      height: getHeight(84),
                      width: getWidth(500), fit: BoxFit.fill,
                    )),
                boxHeight(105),
                Container(
                    child: Image.asset(
                      Assets.imagesWelcome,
                      height: getHeight(511),
                      width: getWidth(459), fit: BoxFit.fill,
                    )),
                boxHeight(64),
                Container(
                  width: getWidth(625),
                  child: text("By utilizing the expert guidance and resources offered by NerdMine, you can confidently make the right career decision and pave the way for a successful future.",
                      textColor: MyColorName.colorTextSecondary,
                      fontFamily: fontRegular,
                      isCentered: true,
                      isLongText: true,
                      fontSize: 10.sp),
                ),
                boxHeight(41),
                InkWell(
                  onTap: (){
                     navigateBackScreen(context, IntroSlider());
                  },
                  child: Container(
                    width: getWidth(625),
                    height: getHeight(90),
                    decoration: boxDecoration(
                      bgColor: MyColorName.primaryLite,
                      radius: 48.sp,
                    ),
                    child: Center(
                      child: text("Get Started",
                          textColor: MyColorName.colorTextPrimary,
                          fontFamily: fontRegular,
                          isLongText: true,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
