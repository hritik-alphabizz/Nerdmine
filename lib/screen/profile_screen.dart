
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/chat_screen.dart';
import 'package:nerdmine/screen/login_screen.dart';
import 'package:nerdmine/screen/plan_screen.dart';
import 'package:nerdmine/screen/reset_password_screen.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/screen/student_profile_screen.dart';
import 'package:nerdmine/screen/terms.dart';
import 'package:nerdmine/screen/wish_screen.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import 'counselling_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  String name="",image="";
  getData()async{
        await App.init();
        setState((){
          name = App.localStorage.getString("name")!;
          image = App.localStorage.getString("profile")!;
        });
        
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
          InkWell(
            onTap: (){
              navigateScreen(context, ChatListScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/msg.png")),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            image!=""?ListTile(
              tileColor: MyColorName.colorBg1,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const StudentProfileScreen()));
              },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: commonImage(image, 100.0, 100.0, "", context, "")),
              title:   text(name,textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp),
              subtitle:   text("View Profile",textColor: Color(0xff6D6D6D),fontFamily: fontMedium,fontSize: 10.sp),
            ):SizedBox(),
            boxHeight(40),
            Container(
              color:MyColorName.colorBg1 ,
              alignment: Alignment.center,
              height: getHeight(140),
              child: ListTile(
                onTap: (){
                  navigateScreen(context, PlanScreen());
                },
                tileColor: MyColorName.colorBg1,
                leading: Image.asset("images/crown.png"),
                title:   text("View premium membership plans",textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 10.sp),
              ),
            ),
            boxHeight(25),
            ListTile(
              onTap: (){
                navigateScreen(context,WishListScreen()) ;
              },
              tileColor: MyColorName.colorBg1,
              leading: Image.asset("images/saved.png",height: getHeight(40),width: getWidth(50),),
              title:   text("Saved Items",textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp),
            ),
            boxHeight(25),
            ListTile(
              onTap: (){
                navigateScreen(context,ResetPasswordScreen()) ;
              },
              tileColor: MyColorName.colorBg1,
              leading: Image.asset("images/change_pass.png",height: getHeight(40),width: getWidth(50),),
              title:   text("Change password",textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp),
            ),
            boxHeight(25),
            ListTile(
              onTap: (){
                navigateScreen(context,Terms("2")) ;
              },
              tileColor: MyColorName.colorBg1,
              leading: Image.asset("images/privacy.png",height: getHeight(40),width: getWidth(50),),
              title:   text("Privacy policy",textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp),
            ),
            boxHeight(25),
            ListTile(
              onTap: (){
                navigateScreen(context,Terms("1")) ;
              },
              tileColor: MyColorName.colorBg1,
              leading: Image.asset("images/terms.png",height: getHeight(40),width: getWidth(50),),
              title:   text("Terms and conditions",textColor: MyColorName.colorTextPrimary,fontFamily: fontMedium,fontSize: 10.sp),
            ),
            boxHeight(25),
            ListTile(
              onTap: () {
                navigateScreen(context, Terms("3"));
              },
              tileColor: MyColorName.colorBg1,
              leading: Image.asset(
                "images/faq.png",
                height: getHeight(40),
                width: getWidth(50),
              ),
              title: text("FAQs", textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
            ),
            boxHeight(30),
            InkWell(
              onTap: () {
                navigateScreen(context, CounsellingForm());
              },
              child: ListTile(
                tileColor: Colors.white,
                leading: Image.asset("images/consulting.png"),
                title: text("Counselling Application form", textColor: Color(0xff5E5E5E), fontFamily: fontMedium, fontSize: 10.sp),
                subtitle: text("(If you need one to one counselling fill application form)",
                    textColor: Color(0xff333333), fontFamily: fontMedium, fontSize: 7.sp),
              ),
            ),
            boxHeight(30),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Do You Want to Logout ?"),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('No'),
                            /*   textColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.transparent)),*/
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                              child: Text('Yes'),
                              /* shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.transparent)),
                                textColor: Theme.of(context).colorScheme.primary,*/
                              onPressed: () async {
                                await App.init();
                                App.localStorage.clear();
                                //Common().toast("Logout");
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                              }),
                        ],
                      );
                    });
              },
              child: Container(
                color: MyColorName.primaryLite,
                height: getHeight(90),
                child: Center(
                  child: text("Logout",
                      textColor: MyColorName.colorTextPrimary,
                      fontFamily: fontRegular,
                      isLongText: true,
                      fontSize: 14.sp),
                ),
              ),
            ),
            boxHeight(40),
          ],
        ),
      ),
    );
  }
}
