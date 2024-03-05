import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/model/connect_count_response.dart';
import 'package:nerdmine/model/connection_model.dart';
import 'package:nerdmine/screen/connect_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({Key? key}) : super(key: key);

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List<CoachModel> coachList = [
    CoachModel("1", "Connections", "images/connect.png"),
    CoachModel("2", "People Follow", "images/people.png"),
    // CoachModel("3", "Hashtags", "images/hashtag.png"),
    CoachModel("4", "Companies", "images/company.png"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnection();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true,acceptStatus = false,connectionStatus = false;
  getConnection() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(
        baseUrl + "userConnectionInfo/2"));
    setState(() {
      loading = false;
    });
    if (response['status']) {
      for (var v in response['info']['connection_info']['connection_list']) {
        connectionList.add(ConnectionModel.fromJson(v));
      }
      for (var v in response['info']['request_connection_info']['request_list']) {
        requestList.add(ConnectionModel.fromJson(v));
      }
      for (var v in response['info']['people_you_may_know']) {
        peopleList.add(PeopleModel.fromJson(v));
      }
    }
  }

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
          setState(() {
            connectionList = [];
            requestList = [];
            peopleList = [];
          });
          getConnection();
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
  sendConnection(sendId, receiveId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "sender_user_id": sendId,
          "receiver_user_id": receiveId,
        };
        Map response = await apiBaseHelper.postAPICall(
            Uri.parse(baseUrl + "sendConnectionRequest"), data);
        print(response);
        bool status = true;
        setState(() {
          connectionStatus = false;
        });
        if (response['status']) {
          setState(() {
            connectionList = [];
            requestList = [];
            peopleList = [];
          });
          getConnection();
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

  int length = 0;
  List<ConnectionModel> connectionList = [];
  List<ConnectionModel> requestList = [];
  List<PeopleModel> peopleList = [];

  ConnectionCount? connectionCount;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F4F8),
      appBar: AppBar(
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
                Assets.imagesBack, fit: BoxFit.fill,
              )),
        ),
        backgroundColor: Color(0xffF2F4F8),
        elevation: 1,
        title: text(
            "Manage Connection".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
      ),
      body: Container(
        color: MyColorName.colorBg1,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            boxHeight(30),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: coachList.map((e) {
                return rowItem(e.title, e.image, e.id);
              }).toList(),
            ),
            boxHeight(50),
          ],
        ),
      ),
    );
  }

  GestureDetector rowItem(title,image,pos){
    return GestureDetector(
      onTap: () {

        if (pos == "1") {
          navigateScreen(context, ConnectScreen(connectionList));
        }

        if (pos == "2") {

          navigateScreen(context, ConnectScreen(requestList));
        }
      },
      child: Container(
        decoration: boxDecoration(
          bgColor: Colors.white,
          radius: 8,
          showShadow: true,
        ),
        padding: EdgeInsets.all(4),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              boxHeight(8),
              Container(height: getHeight(60), width: getHeight(60), child: Image.asset(image)),
              boxHeight(5),
              text("${getCountByPosition(pos) ?? 00}", textColor: Color(0xff5E5E5E), fontFamily: fontMedium, fontSize: 14.sp),
              boxHeight(5),
              Expanded(child: text(title.toString().toUpperCase(), textColor: Color(0xff5E5E5E), fontFamily: fontRegular, fontSize: 8.sp)),
            ],
          ),
        ),
      ),
    );
  }

  String? getCountByPosition(String position) {
    switch (position) {
      case "1":
        return connectionCount?.totalConnection;
      case "2":
        return connectionCount?.totalFollowing;
      case "3":
        return connectionCount?.totalConnection;
      case "4":
        return connectionCount?.totalCompany;
      default:
        return "00";
    }
  }

  Future<void> getConnectionCounts() async {
    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Dialogs.showLoader(context, "Getting connection details...");
    String userId = App.localStorage.getString("user_id") ?? "";

    ConnectCountResponse response = await apiController.get<ConnectCountResponse>("${EndPoints.MANAGE_CONNECTION}/$userId");

    //hide loader
    await Dialogs.hideLoader(context);
    if (response.status ?? false) {
      connectionCount = response.connectionCount;

      //Update UI
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }
  }
}
