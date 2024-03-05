import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/model/page_model.dart';
import 'package:nerdmine/screen/manage_connection.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class Terms extends StatefulWidget {
  String type;


  Terms(this.type);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool selected =false;
  PageModel? model;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;
  getData()async{
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl+"pageInfo/${widget.type}"));
    if(response['status']){
      setState(() {
        loading = false;
      });
      var v = response['info'];
      model = PageModel.fromJson(v);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              navigateScreen(context, NotificationScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/notify.png")),
            ),
          ),

        ],
        title: text(
            model!=null?model!.pageTitle.toString():"",
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(getWidth(20)),
          child: model!=null?Column(
            children: [
              boxHeight(30),
              Html(data: model!.pageContent.toString()),
            ],
          ):Center(child: CircularProgressIndicator(),),
        ),
      ),



    );
  }
}

