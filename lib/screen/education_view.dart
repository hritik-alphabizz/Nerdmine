import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/screen/experience_screen.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/date_picker_widget.dart';
import 'package:nerdmine/utils/extension.dart';
import 'package:sizer/sizer.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class EducationView extends StatefulWidget {
  const EducationView({Key? key}) : super(key: key);

  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  TextEditingController collegeNameTextController = TextEditingController();
  TextEditingController gradeTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController degreeTextController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();
  String responseMsg = '';

  String? startDate;
  String? endDate;

  @override
  void initState() {
    super.initState();

/*    if (kDebugMode) {
      collegeNameTextController.text = "Chameli devi group of institute";
      gradeTextController.text = "D3";
      startDateTextController.text = "2010-10-30";
      endDateTextController.text = "2020-10-30";
      descriptionTextController.text = "Engineering";
      degreeTextController.text = "B.tech";
      fieldOfStudyController.text = "CS";
    }*/
  }

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
          title: text('Eductaion',
              textColor: MyColorName.primaryDark,
              fontFamily: fontMedium,
              fontSize: 14.sp)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            boxHeight(44),
            TextField(
              controller: collegeNameTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "College",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            boxHeight(54),
            TextField(
              controller: degreeTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Degree",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            boxHeight(54),
            TextField(
              controller: fieldOfStudyController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Field of study",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
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
                initialDate: endDate ,
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
              controller: gradeTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Grade",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ), boxHeight(54),
            TextField(
              controller: descriptionTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
                fillColor: MyColorName.colorBg1,
                filled: true,
                counterText: '',
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "Description",
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
/*  user_id: "2"
    institute_name: "D.A.V Scholl No 2"
    courses_name: "12 Th"
    grade: "A+"
    start_date: "2002-10-30"
    end_date: "2003-10-30"
    description: "I have comaplte my 12 th from this shoolc"*/

    if (collegeNameTextController.text.isEmpty) {FlutterToastX.showErrorToastBottom(context, "Please enter college / Institute name");    return;}
    if (gradeTextController.text.isEmpty) {FlutterToastX.showErrorToastBottom(context, "Please enter grade");    return;}
    if (startDate == null) {
      FlutterToastX.showErrorToastBottom(context, "Please enter start Date".capitalize());
      return;
    }
    if (endDate == null) {
      FlutterToastX.showErrorToastBottom(context, "Please enter end Date".capitalize());
      return;
    }
    if (descriptionTextController.text.isEmpty) {FlutterToastX.showErrorToastBottom(context, "Please enter description");    return;}
    if (degreeTextController.text.isEmpty) {FlutterToastX.showErrorToastBottom(context, "Please enter degree/course name");    return;}
    if (fieldOfStudyController.text.isEmpty) {FlutterToastX.showErrorToastBottom(context, "Please enter field of study");    return;}

    Map<String, dynamic> body = {
      "user_id": App.localStorage.getString("user_id"),
      'institute_name': collegeNameTextController.text.toString(),
      'courses_name': degreeTextController.text.toString(),
      'grade': gradeTextController.text.toString(),
      'start_date': startDate,
      'end_date': endDate,
      'description': descriptionTextController.text.toString(),
    };

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Adding Education to your profile ...");
    AddExperienceReponse response =
        await apiController.post<AddExperienceReponse>('https://developmentalphawizz.com/Nerdmine/webService/addEducationinformation', body: formData);
    await Dialogs.hideLoader(context);
    // Future.delayed(Duration(milliseconds: 600));
    if (response.status ?? false) {
      print(response.toJson());
      Navigator.pop(context);
      FlutterToastX.showSuccessToastBottom(context, "Education Added to your profile");
    } else {
      Common().toast(response.msg ?? "");
    }
  }
}
