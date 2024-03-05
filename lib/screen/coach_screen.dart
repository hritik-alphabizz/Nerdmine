
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/counselling_form.dart';
import 'package:nerdmine/screen/view_course.dart';

import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../model/coach_model.dart';
class CoachScreen extends StatefulWidget {
  const CoachScreen({Key? key}) : super(key: key);

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoach();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getCoach()async{


    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl+"coachCollegeSearch"));
    if(response['status']){
      setState(() {
        loading = false;
      });
      for(var v in response['list']){
        coachList.add(CoachModel.fromJson(v));
      }
    }
  }
  List<CoachModel> coachList = [];
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
            "Coach/College Search".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boxHeight(30),
            text(
                "Coach/College Search".toString(),
                textColor: MyColorName.primaryDark,fontFamily: fontRegular,fontSize: 10.sp
            ),
            boxHeight(20),
            coachList.length>0?GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1.9,
              mainAxisSpacing: getWidth(20),
              crossAxisSpacing: getWidth(20),
              children: coachList.map((e) {
                    return rowItem(e.categoryTitle, e.image, e.categoryId,e);
              }).toList(),
            ):Center(child: CircularProgressIndicator(),),
            Spacer(),
            InkWell(
              onTap: () {
                navigateScreen(context,  CounsellingForm());
              },
              child: ListTile(
                tileColor: Colors.white,
                leading: Image.asset("images/consulting.png"),
                title:text("Counselling Application form",textColor: Color(0xff5E5E5E),fontFamily: fontMedium,fontSize: 10.sp),
                subtitle:   text("(If you need one to one counselling fill application form)",textColor: Color(0xff333333),fontFamily: fontMedium,fontSize: 7.sp),
              ),
            ),
            boxHeight(30),
          ],
        ),
      ),
    );
  }
  GestureDetector rowItem(title,image,pos,model){
    return GestureDetector(
      onTap: (){
        navigateScreen(context, ViewCourse(model));
      },
      child: Container(
        decoration: boxDecoration(
          bgColor: Colors.white,
          radius: 8,
        ),
        padding: EdgeInsets.all(getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: getHeight(60),
                width: getHeight(60),
                child: commonImage(image, 60.0, 60.0, "", context, "")),
            boxHeight(10),
            text(
                title.toString().toUpperCase(),
                textColor:pos==1?MyColorName.primaryLite:MyColorName.primaryDark,fontFamily: fontRegular,fontSize: 8.sp
            ),
          ],
        ),
      ),
    );
  }
}
