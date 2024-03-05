import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/home_screen.dart';
import 'package:nerdmine/screen/welcome_screen.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';


import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePage();
  }

  changePage() async {
    await Future.delayed(Duration(seconds: 3));
    await App.init();
    if(App.localStorage.getString("user_id")!=null){
      curUserId = App.localStorage.getString("user_id");
      navigateBackScreen(context, HomeScreen());
    }else{
      navigateBackScreen(context, WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        height: getHeight(1280),
        width: getWidth(720),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesSplashBg,
            ),
            fit: BoxFit.fill
          ),
         ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleAnimatedWidget.tween(
                enabled: true,
                duration: Duration(milliseconds: 600),
                scaleDisabled: 0.5,
                scaleEnabled: 1,
                child: Container(
                    child: Image.asset(
                      "images/logo.png",
                      height: getHeight(150),
                      width: getWidth(600), fit: BoxFit.fill,
                    ))),
          ],
        ),
      ),
    );
  }
}
