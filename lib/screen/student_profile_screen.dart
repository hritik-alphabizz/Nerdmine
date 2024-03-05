import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/model/upload_img_response.dart';
import 'package:nerdmine/screen/education_view.dart';
import 'package:nerdmine/screen/experience_screen.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/screen/skill_detail_screen.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:sizer/sizer.dart';

import '../api/api_controller_expo.dart';
import '../api/end_points.dart';
import '../generated/assets.dart';
import '../model/user_info_response.dart';
import '../res/AppColors.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/flutter_toast.dart';
import '../utils/progress_dialog.dart';
import '../utils/widget.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  late String? userId, name, email, userProfileImage;

  @override
  void initState() {
    super.initState();

    userId = App.localStorage.getString("user_id");
    name = App.localStorage.getString("name");
    email = App.localStorage.getString("email");
    userProfileImage = App.localStorage.getString("profile");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
          actions: [
            InkWell(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => SkillDetailScreen()));
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
          title: text('${response?.userInfo?.userType??""} Profile',
              textColor: MyColorName.primaryDark,
              fontFamily: fontMedium,
              fontSize: 14.sp)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [

                Container(
                  height: 26.h,
                  decoration: BoxDecoration(
                    image:  (response?.userInfo?.coverImage == null) ?
                    DecorationImage(image: AssetImage(Assets.imagesIcCompany), fit: BoxFit.cover)
                    : DecorationImage(
                      image: NetworkImage("${response?.userInfo?.coverImage}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: response != null
                                      ? commonImage(response?.userInfo?.profileImagePath, 100.0, 100.0, "", context, "")
                                      : commonImage(userProfileImage, 100.0, 100.0, "", context, ""),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () async {
                                    updateProfileImage(await pickMultipartImg(context));
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    height: 20,
                                    decoration: const BoxDecoration(color: MyColorName.primaryDark, shape: BoxShape.circle),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                                    width: 20,
                                  ),
                                ),
                              ),
                            ]),
                            verticalSpace(4.0),
                            Text(
                              "${response != null ? response?.userInfo?.name : name}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: MyColorName.textwhite,
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${response != null ? response?.userInfo?.email : email}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: IconButton(
                              onPressed: () async {
                                updateProfileImage2(await pickMultipartImg(context));
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: MyColorName.primaryDark,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text('Experience  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                      InkWell(
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => ExperienceScreen()));
                          getProfileDetailWithoutLoader();
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: MyColorName.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  boxHeight(20),
                  response!=null?ListView.builder(
                      shrinkWrap: true,
                      itemCount: response?.userInfo?.experienceInfo?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(Assets.imagesBlueBag,height: getHeight(50)),
                              boxWidth(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        text('${response?.userInfo?.experienceInfo![index].companyName}  ',
                                            textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                                        boxHeight(10),
                                        text('${response?.userInfo?.experienceInfo![index].positionInCompany}',
                                            textColor: AppColors.black, fontFamily: fontBold, fontSize: 10.sp),
                                        boxHeight(5),
                                        Row(
                                          children: [
                                            text('${response?.userInfo?.experienceInfo![index].startDate} Present  ',
                                                textColor: Color(0xFFB7B7B7), fontFamily: fontRegular, fontSize: 12.sp),
                                            text(' | 1 year 5 mos  ', textColor: AppColors.black, fontFamily: fontRegular, fontSize: 12.sp),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                            ],
                          ),
                        );
                      }):text(''),
                ],
              ),
            ),

            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text('Education  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                      InkWell(
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => EducationView()));
                          getProfileDetailWithoutLoader();
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: MyColorName.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  boxHeight(20),
                  response!=null?ListView.builder(
                      shrinkWrap: true,
                      itemCount: response?.userInfo?.educationInfo?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Image.asset(Assets.imagesEducation, height: getHeight(50.0)),
                              boxWidth(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        text('${response?.userInfo?.educationInfo?[index].instituteName} ',
                                            textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                                        boxHeight(10),
                                        text('${response?.userInfo?.educationInfo?[index].coursesName}',
                                            textColor: AppColors.black, fontFamily: fontBold, fontSize: 10.sp),
                                        boxHeight(5),
                                        text(
                                            '${response?.userInfo?.educationInfo?[index].startDate} to ${response?.userInfo?.educationInfo?[index].endDate}',
                                            textColor: AppColors.black,
                                        fontFamily: fontBold,
                                        fontSize: 10.sp),
                                    boxHeight(5),
                                  ],
                                ),
                              )
                                ],
                          ),
                        );
                      }):text(''),
                ],
              ),
            ),

            SizedBox(
              height: 2.h,
            ),

            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text('Skill  ', textColor: Color(0xFF02778B), fontFamily: fontBold, fontSize: 15.sp),
                      InkWell(
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => SkillDetailScreen()));
                          getProfileDetailWithoutLoader();
                          /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EducationView()));*/
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: MyColorName.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  boxHeight(20),
                  response!=null ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: response?.userInfo?.skillsList?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              boxWidth(20),
                              Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        text('${response?.userInfo?.skillsList?[index].skillTitle}',
                                            textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                      }):text(''),
                ],
              ),
            ),
            /*  ListTile(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CertificationScreen()));
              },
              tileColor: Colors.white,
              title: Text(
                "Certification",
                style: TextStyle(
                    color: MyColorName.primaryDark,
                    fontFamily: fontMedium,
                    fontSize: 16.sp),
              ),
              subtitle: Text(
                "Tell us about your Certification",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: fontRegular,
                    fontSize: 10.5.sp),
              ),
              trailing: const Icon(
                Icons.add,
                size: 30,
                color: MyColorName.primaryDark,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            ListTile(
              onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfessionView()));
              },
              tileColor: Colors.white,
              title: Text(
                "Choice of profession",
                style: TextStyle(
                    color: MyColorName.primaryDark,
                    fontFamily: fontMedium,
                    fontSize: 16.sp),
              ),
              subtitle: Text(
                "Tell us about your choice of profession",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: fontRegular,
                    fontSize: 10.5.sp),
              ),
              trailing: const Icon(
                Icons.add,
                size: 30,
                color: MyColorName.primaryDark,
              ),
            ),*/

            SizedBox(
              height: 2.h,
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Row(
                children: [
                  Expanded(
                      flex: 1, child: Image.asset('images/crown.png')),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Join our premium membership plans and get push notifications for fresher job posting and full job details",
                        style: TextStyle(fontSize: 11.sp),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  UserInfoResponse? response;

  Future<void> getProfileDetail() async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Map<String, dynamic> body = {"user_id": App.localStorage.getString("user_id")};

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Getting user profile detail ...");
    response = await apiController.post<UserInfoResponse>(EndPoints.USER_PROFILE_RESPONSE, body: formData);

    //hide loader
    await Dialogs.hideLoader(context);
    if (response?.status ?? false) {
      //Update UI
      App.localStorage.setString("profile", response?.userInfo?.profileImagePath ??"");

      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
    }
  }

  Future<void> getProfileDetailWithoutLoader() async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Map<String, dynamic> body = {"user_id": App.localStorage.getString("user_id")};

    var formData = FormData.fromMap(body);

    // Dialogs.showLoader(context, "Getting user profile detail ...");
    response = await apiController.post<UserInfoResponse>(EndPoints.USER_PROFILE_RESPONSE, body: formData);

    //hide loader
    // await Dialogs.hideLoader(context);
    if (response?.status ?? false) {
      //Update UI
      App.localStorage.setString("profile", response?.userInfo?.profileImagePath ??"");

      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
    }
  }

  Future<void> updateProfileImage(File? file) async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    if (file == null) {
      FlutterToastX.showErrorToastBottom(context, "File not found");
    }

    Map<String, dynamic> body = {
      "user_id": userId,
      "profile_image":  await MultipartFile.fromFile(file?.path ?? ""),
    };

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Updating profile picture");
    UploadImgResponse response = await apiController.post<UploadImgResponse>(EndPoints.UPLOAD_PROFILE, body: formData);
    await Dialogs.hideLoader(context);
    if (response?.status ?? false) {
      //Update UI

      getProfileDetailWithoutLoader();
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
    }
  }

  Future<void> updateProfileImage2(File? file) async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    if (file == null) {
      FlutterToastX.showErrorToastBottom(context, "File not found");
    }

    Map<String, dynamic> body = {
      "user_id": userId,
      "cover_image": await MultipartFile.fromFile(file?.path ?? ""),
    };

    print(body);
    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Updating profile picture");
    UploadImgResponse response =
        await apiController.post<UploadImgResponse>("https://developmentalphawizz.com/Nerdmine/webService/updateCoverImage", body: formData);
    await Dialogs.hideLoader(context);
    if (response?.status ?? false) {
      //Update UI

      getProfileDetailWithoutLoader();
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
    }
  }

  static Future<File?> pickMultipartImg(BuildContext context) async {
    try {
      FilePickerResult result = await (FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpeg', "jpg"],
      ) as FutureOr<FilePickerResult>);

      File file = File(result.files.single.path!);

      return file;
    } catch (e) {
      FlutterToastX.showErrorToastBottom(context, "Failed to pick image");
      return null;
    }
  }
}
