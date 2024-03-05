
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/model/connection_model.dart';
import 'package:nerdmine/screen/manage_connection.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class RequestScreen extends StatefulWidget {
  List<RequestModel> requestList = [];


  RequestScreen(this.requestList);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true,acceptStatus = false;
  bool isNetwork = false;
  acceptConnection(id, status1) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "connection_request_id": id,
          "status": status1,
        };
        Map response = await apiBaseHelper.postAPICall(
            Uri.parse(baseUrl + "connectionRequestAcceptORReject"), data);
        print(response);
        bool status = true;
        setState(() {
          acceptStatus = false;
        });
        if (response['status']) {
            Navigator.pop(context,true);
        } else {}
        String msg = response['msg'];
        // setSnackbar(msg, context);
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
            "Request".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:getWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boxHeight(30),
              widget.requestList.length>0?ListView.separated(
                  itemCount: widget.requestList.length,
                  separatorBuilder: (context,index){
                    return boxHeight(20);
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    RequestModel model = widget.requestList[index];
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tileColor: MyColorName.colorBg1,
                      contentPadding: EdgeInsets.all(10),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: commonImage(model.profileImage,
                              100.0, 100.0, "", context, "")),
                      title:  text(getString(model.name.toString()),textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 10.sp),
                      trailing:!acceptStatus?Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap:(){
                              setState(() {
                                acceptStatus = true;
                              });
                              acceptConnection(model.connectionRequestId,"2");
                            },
                            child: Container(
                              width: getHeight(60),
                              height: getHeight(60),
                              decoration: boxDecoration(
                                bgColor: MyColorName.colorBg1,
                                radius: 30.sp,
                                color: MyColorName.colorTextSecondary,
                              ),
                              child: Center(
                                child: Icon(Icons.close,color: MyColorName.colorTextSecondary,),
                              ),
                            ),
                          ),
                          boxWidth(10),
                          InkWell(
                            onTap:(){
                              setState(() {
                                acceptStatus = true;
                              });
                              acceptConnection(model.connectionRequestId,"1");
                            },
                            child: Container(
                              width: getHeight(60),
                              height: getHeight(60),
                              decoration: boxDecoration(
                                bgColor: MyColorName.colorBg1,
                                radius: 30.sp,
                                color: MyColorName.primaryDark,
                              ),
                              child: Center(
                                child: Icon(Icons.check,color: MyColorName.primaryDark,),
                              ),
                            ),
                          ),
                        ],
                      ):CircularProgressIndicator(color: MyColorName.colorBg1,),
                      subtitle:   Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(model.skills.toString(),textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                        /*  Row(
                            children: [
                              Image.asset("images/mutual.png",width: getWidth(30),height: getHeight(30),),
                              text("7 Mutual connections",textColor: Color(0xff6D6D6D),fontFamily: fontRegular,fontSize: 7.5.sp),
                            ],
                          ),*/
                        ],
                      ),
                    );
                  })  : Center(
                child: text("No Result Found",
                    textColor: MyColorName.primaryDark,
                    fontFamily: fontMedium,
                    fontSize: 10.sp),
              ),
              boxHeight(30),
            ],
          ),
        ),
      ),
    );
  }
}
