import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/model/PostCounsellingResposne.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class CounsellingForm extends StatefulWidget {
  const CounsellingForm({Key? key}) : super(key: key);

  @override
  State<CounsellingForm> createState() => _CounsellingFormState();
}

class _CounsellingFormState extends State<CounsellingForm> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      // jobTypeString = "Private job";
      // employmentTypeString = "Full Time";
      // jobTimingString = "Monday to Friday";
      // salaryTypeString = "Month";
      //
      // jobTitleController.text = "Hardwear networking";
      // companyNameController.text = "SCS Infotect";
      // positionController.text = "SR";
      // noOfVacancyController.text = "1";
      // locationController.text = "SCS Infotect";
      // experienceRequiredController.text = "minimum 1 year";
      // educationRequiredController.text = "PG required";
      // documentRequiredController.text = "PG Markshit";
      // skillsRequiredController.text = "nolege about Hardwear networking";
      // salaryController.text = "25000";
      // attachmentsRequiredController.text = "";
    }
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
          title: text('Counselling Form', textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  boxHeight(54),
                  inputField("Full Name", fullNameController),
                  boxHeight(54),
                  inputField("Mobile Number", mobileNumberController, number: true),
                  boxHeight(54),
                  inputField("Email", emailController),
                  boxHeight(54),
                  inputField("Message", messageController, multiline: 5),
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
                    uploadForm();
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

  inputField(String type, TextEditingController controller, {int? multiline, bool number = false}) {
    return TextField(
      controller: controller,
      keyboardType: number ? TextInputType.number : TextInputType.multiline,
      maxLines: multiline == null ? 1 : null,
      maxLength: number ? 10 : null,
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
      ],
    );
  }

  uploadForm() async {
    String curUserId = App.localStorage.getString("user_id") ?? "";

    String? fullNameError = validateFullName(fullNameController.text);
    if (fullNameError == null) return;

    String? mobileNumberError = validateMobileNumber(mobileNumberController.text);
    if (mobileNumberError == null) return;

    String? emailError = validateEmail(emailController.text);
    if (emailError == null) return;

    String? messageError = validateMessage(messageController.text);
    if (messageError == null) return;

    Map<String, String> body = {
      "user_id": curUserId,
      "page_id": "1",
      "full_name": fullNameController.text.toString(),
      "mobile_number": mobileNumberController.text.toString(),
      "email": emailController.text.toString(),
      "message": messageController.text.toString(),
    };

    Dialogs.showLoader(context, "Submitting Counselling form ...");
    var formData = FormData.fromMap(body);
    PostCounsellingResposne response =
        await apiController.post<PostCounsellingResposne>('https://developmentalphawizz.com/Nerdmine/webService/saveCounsellingInfo', body: formData);
    await Dialogs.hideLoader(context);
    // Future.delayed(Duration(milliseconds: 600));
    if (response.status ?? false) {
      FlutterToastX.showSuccessToastBottom(context, response.msg ?? "");
      Navigator.pop(context);
      print(response.toJson());
    } else {
      Common().toast("Something went wrong");
    }
  }

// Validate full name field
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter your full name');
      return null;
    }
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter a valid name');
      return null;
    }
    if (value.length < 2 || value.length > 50) {
      FlutterToastX.showErrorToastBottom(context, 'Name must be between 2 and 50 characters');
      return null;
    }
    return value;
  }

// Validate mobile number field
  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter your mobile number');
      return null;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter a valid mobile number');
      return null;
    }
    if (value.length < 7 || value.length > 15) {
      FlutterToastX.showErrorToastBottom(context, 'Mobile number must be between 7 and 15 digits');
      return null;
    }
    return value;
  }

// Validate email field
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter your email address');
      return null;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter a valid email address');
      return null;
    }
    if (value.length > 254) {
      FlutterToastX.showErrorToastBottom(context, 'Email address must be less than 254 characters');
      return null;
    }
    return value;
  }

// Validate message field
  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, 'Please enter your message');
      return null;
    }
    if (value.length > 1000) {
      FlutterToastX.showErrorToastBottom(context, 'Message must be less than 1000 characters');
      return null;
    }
    return value;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
