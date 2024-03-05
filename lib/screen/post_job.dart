import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/model/post_job_picklist_response.dart';
import 'package:nerdmine/res/AppColors.dart';
import 'package:nerdmine/res/Fonts.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController joDescriptionController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController noOfVacancyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController experienceRequiredController = TextEditingController();
  TextEditingController educationRequiredController = TextEditingController();
  TextEditingController documentRequiredController = TextEditingController();
  TextEditingController skillsRequiredController = TextEditingController();
  TextEditingController attachmentsRequiredController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  List<String> jobType = [];
  List<String> employmentType = [];
  List<String> jobTiming = [];
  List<String> salaryType = [];

  String? jobTypeString;
  String? employmentTypeString;
  String? jobTimingString;
  String? salaryTypeString;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      jobTypeString = "Private job";
      employmentTypeString = "Full Time";
      jobTimingString = "Monday to Friday";
      salaryTypeString = "Month";

      jobTitleController.text = "Hardwear networking";
      companyNameController.text = "SCS Infotect";
      positionController.text = "SR";
      noOfVacancyController.text = "1";
      locationController.text = "SCS Infotect";
      experienceRequiredController.text = "minimum 1 year";
      educationRequiredController.text = "PG required";
      documentRequiredController.text = "PG Markshit";
      skillsRequiredController.text = "nolege about Hardwear networking";
      salaryController.text = "25000";
      // attachmentsRequiredController.text = "";
    }
    getPicklistValues();
  }

  bool checkValue = false;

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
          title: text('Post Job', textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  boxHeight(54),
                  inputField2(jobTypeString ?? "Job Type", jobType, "1"),
                  boxHeight(54),
                  inputField("Job Title", jobTitleController),
                  boxHeight(54),
                  inputField("Job Description", joDescriptionController, multiline: 5),
                  boxHeight(54),
                  inputField("Company Name", companyNameController),
                  boxHeight(54),
                  inputField2(employmentTypeString ?? "Employment Type", employmentType, "2"),
                  boxHeight(54),
                  inputField("Position", positionController),
                  boxHeight(54),
                  inputField("No of vacancy", noOfVacancyController),
                  boxHeight(54),
                  inputField2(jobTimingString ?? "Timing", jobTiming, "3"),
                  boxHeight(54),
                  inputField("Salary", salaryController),
                  boxHeight(54),
                  inputField2(salaryTypeString ?? "Salary Type", salaryType, "4"),
                  boxHeight(54),
                  inputField("Location", locationController),
                  boxHeight(54),
                  inputField("Experience Required", experienceRequiredController),
                  boxHeight(54),
                  inputField("Education Required", educationRequiredController),
                  boxHeight(54),
                  inputField("Document Required", documentRequiredController),
                  boxHeight(54),
                  inputField("Skills Required", skillsRequiredController),
                  boxHeight(54),
                  // inputField("Attachments", attachmentsRequiredController),
                  // boxHeight(54),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade800, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999))),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    postJob();
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

  inputField(String type, TextEditingController controller, {int? multiline}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: multiline == null? 1 : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48.sp),
          borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
        ),
        fillColor: MyColorName.colorBg1,
        filled: true,
        counterText: '',

        contentPadding: EdgeInsets.all(getWidth(30)),
        hintText: "$type",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48.sp),
          borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
        ),
      ),
    );
  }

  inputField2(String title, List<String> type, String updaterField) {
    return Stack(
      children: [
        TextField(
          focusNode: new AlwaysDisabledFocusNode(),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.sp),
              borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
            ),
            fillColor: MyColorName.colorBg1,
            filled: true,
            counterText: '',
            contentPadding: EdgeInsets.all(getWidth(30)),
            hintText: "$title",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.sp),
              borderSide: BorderSide(color: MyColorName.colorTextSecondary.withOpacity(0.2)),
            ),
          ),
        ),
        Positioned.fill(
            child: InkWell(
                onTap: () {
                  showAttachmentOptions(type, updaterField);
                },
                child: Container()))
      ],
    );
  }

  getPicklistValues() async {
    Dialogs.showLoader(context, "Getting picklist value ...");
    PostJobPicklistResponse response = await apiController.get<PostJobPicklistResponse>('https://developmentalphawizz.com/Nerdmine/webService/jobPostFormData');
    await Dialogs.hideLoader(context);
    // Future.delayed(Duration(milliseconds: 600));
    if (response.status ?? false) {
      print(response.toJson());
      employmentType.clear();
      jobType.clear();
      salaryType.clear();
      jobTiming.clear();

      employmentType.addAll(response.employmentType ?? []);
      jobType.addAll(response.jobType ?? []);
      salaryType.addAll(response.salaryRateType ?? []);
      jobTiming.addAll(response.jobTiming ?? []);
    } else {
      Common().toast("Something went wrong");
    }
  }

  postJob() async {

    if (jobTypeString?.isEmpty ?? true ) { FlutterToastX.showErrorToastBottom(context ,  "Please enter job type"); return;  } //
    if (jobTitleController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter job Title"); return;  } //
    if (joDescriptionController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter job description"); return;  } //
    if (companyNameController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter company Name"); return;  } //
    if (employmentTypeString?.isEmpty ?? true) { FlutterToastX.showErrorToastBottom(context,  "Please enter employment Type"); return;  }//
    if (positionController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter position"); return;  }//
    if (locationController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter location"); return;  }//
    if (jobTypeString?.isEmpty ?? true ) { FlutterToastX.showErrorToastBottom(context ,  "Please enter job Type "); return;  }//
    if (noOfVacancyController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context ,  "Please enter no of vacancy"); return;  } //
    if (salaryController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter salary"); return;  } //
    if (salaryTypeString?.isEmpty ?? true ) { FlutterToastX.showErrorToastBottom(context,  "Please enter salary type"); return;  } //
    if (jobTitleController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter job title"); return;  }//
    if (experienceRequiredController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter experience required or not"); return;  }//
    if (educationRequiredController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context ,  "Please enter education required or not"); return;  } //
    if (documentRequiredController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter document required or not"); return;  } //
    if (skillsRequiredController.text.toString().isEmpty ) { FlutterToastX.showErrorToastBottom(context,  "Please enter skills required or not"); return;  } //



    Map<String, dynamic> body = {
      "user_id": curUserId,
      "job_type": jobTypeString,
      "job_title": jobTitleController.text.toString(),
      "employment_type": employmentTypeString,
      "position": positionController.text.toString(),
      "company_name": companyNameController.text.toString(),
      "location": locationController.text.toString(),
      "job_timing": jobTypeString,
      "no_of_vacancy": noOfVacancyController.text.toString(),
      "salary": salaryController.text.toString(),
      "salary_rate_type": salaryTypeString,
      "jobs_description": joDescriptionController.text.toString(),
      "experience_required": experienceRequiredController.text.toString(),
      "education_required": educationRequiredController.text.toString(),
      "document_required": documentRequiredController.text.toString(),
      "skills_required": skillsRequiredController.text.toString(),
      "attachment_file": "",
    };

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Getting picklist value ...");
    PostJobPicklistResponse response = await apiController.post<PostJobPicklistResponse>('https://developmentalphawizz.com/Nerdmine/webService/jobPost', body: formData);
    await Dialogs.hideLoader(context);
    // Future.delayed(Duration(milliseconds: 600));
    if (response.status ?? false) {
      print(response.toJson());
      Navigator.pop(context);
    } else {
      Common().toast("Something went wrong");
    }
  }



  void showAttachmentOptions(List<String> listOfValues, String updaterField) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select attachment type", style: textStyle14px600w),
                    verticalSpace(10.0),
                    ...listOfValues.map((e) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, e);
                        },
                        child: Container(
                          color: AppColors.inputFieldBackgroundColor,
                          padding: EdgeInsets.all(20.0),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(e, style: textStyleSubText14px500w)),
                                  horizontalSpace(10.0),
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.textColorSubText,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) async {
      if (updaterField == "1") {
        jobTypeString = value;
      } else if (updaterField == "2") {
        employmentTypeString = value;
      } else if (updaterField == "3") {
        jobTimingString = value;
      } else if (updaterField == "4") {
        salaryTypeString = value;
      }

      setState(() {});
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}