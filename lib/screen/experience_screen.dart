import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/api/api_controller_expo.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/utils/date_picker_widget.dart';
import 'package:nerdmine/utils/extension.dart';
import 'package:nerdmine/utils/progress_dialog.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  TextEditingController jobTitle = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController industryContr = TextEditingController();
  TextEditingController employementTitle = TextEditingController();
  TextEditingController companyName = TextEditingController();

  String responseMsg = '';

  @override
  void initState() {
    super.initState();

    /* if (kDebugMode) {
      jobTitle.text = "SR. Developer";
      locationController.text = "Indore";
      startDateCont.text = "2010-10-30";
      endDateContr.text = "2020-10-30";
      industryContr.text = "Textile Sectore";
      employementTitle.text = "Freelancer";
      companyName.text = "TCS";
    }*/
  }

  bool checkValue = false;
  String? startDate;
  String? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: text('Experience',
              textColor: MyColorName.primaryDark,
              fontFamily: fontMedium,
              fontSize: 14.sp)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            boxHeight(44),
            TextField(
              controller: jobTitle,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Job title",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            boxHeight(54),
            TextField(
              controller: employementTitle,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Employment title",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            boxHeight(54),
            TextField(
              controller: companyName,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Company Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            boxHeight(34),

            TextField(
              controller: locationController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Location",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ), boxHeight(33),
            Row(
              children: [
                Checkbox(
                    value: checkValue,
                    onChanged: (_) {
                      setState(() {
                        checkValue = !checkValue;
                      });
                    }),
                Text("I am currently working in this role"),
              ],
            ),
            boxHeight(54),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48.sp),
                color: MyColorName.colorBg1,
                border: Border.all(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
              ),
              child: DatePickerWidget(
                initialDate: startDate,
                displayText: "Select start date",
                onDateSelected: (String date) {
                  setState(() {
                    startDate = date;
                  });
                },
              ),
            ),
            boxHeight(33),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48.sp),
                color: MyColorName.colorBg1,
                border: Border.all(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
              ),
              child: DatePickerWidget(
                initialDate: endDate,
                displayText: "Select end date",
                onDateSelected: (String date) {
                  setState(() {
                    endDate = date;
                  });
                },
              ),
            ),
            boxHeight(54),
            TextField(
              controller: industryContr,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',

                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Industry",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            boxHeight(54),
            Container(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade800, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999))),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    callExperienceApi();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            boxHeight(54),
          ],
        ),
      ),
    );
  }

  callExperienceApi() async {
    if (jobTitle.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter job Title".capitalize());
      return;
    }
    if (locationController.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter location Controller".capitalize());
      return;
    }
    if (startDate == null) {
      FlutterToastX.showErrorToastBottom(context, "Please enter start Date".capitalize());
      return;
    }
    if (endDate == null) {
      FlutterToastX.showErrorToastBottom(context, "Please enter end Date".capitalize());
      return;
    }
    if (industryContr.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter industry".capitalize());
      return;
    }
    if (employementTitle.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter employment Title".capitalize());
      return;
    }
    if (companyName.text.toString().isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please enter company Name".capitalize());
      return;
    }

    Map<String, dynamic> body = {
      "user_id": App.localStorage.getString("user_id"),
      'position_in_company': jobTitle.text,
      'employment_type': employementTitle.text,
      'company_name': companyName.text,
      'location': locationController.text,
      'current_working_role': 'no',
      'start_date': startDate,
      'end_date': endDate,
      'industry': industryContr.text,
    };

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Adding experience ...");
    AddExperienceReponse response = await apiController.post<AddExperienceReponse>('https://developmentalphawizz.com/Nerdmine/webService/addExperienceInformation', body: formData);
    await Dialogs.hideLoader(context);
    // Future.delayed(Duration(milliseconds: 600));
    if (response.status ?? false) {
      print(response.toJson());
      Navigator.pop(context);
      FlutterToastX.showSuccessToastBottom(context, "Experience Added to your profile");
    } else {
      Common().toast(response.msg ?? "");
    }
  }
}

class AddExperienceReponse {
  AddExperienceReponse({
    bool? status,
    String? msg,
  }) {
    _status = status;
    _msg = msg;
  }

  AddExperienceReponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
  }

  bool? _status;
  String? _msg;

  AddExperienceReponse copyWith({
    bool? status,
    String? msg,
  }) =>
      AddExperienceReponse(
        status: status ?? _status,
        msg: msg ?? _msg,
      );

  bool? get status => _status;

  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    return map;
  }
}