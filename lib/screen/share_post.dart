import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/model/post_created_response.dart';
import 'package:nerdmine/model/post_line_item_bottom_sheet_response.dart';
import 'package:nerdmine/res/AppColors.dart';
import 'package:nerdmine/res/Fonts.dart';
import 'package:nerdmine/utils/flutter_toast.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class SharePost extends StatefulWidget {
  const SharePost({Key? key}) : super(key: key);

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  TextEditingController desc = TextEditingController();

  callApiOnPost() async {
    http.Response response = await http.post(
        Uri.parse('https://alphawizztest.tk/Nerdmine/webService/postFeed'),
        body: {
          'user_id': '2',
          'feed_category_id': '1',
          'see_your_post': '1',
          'description': 'asdasdasdasd',
          'add_content_type': '3',
          'content_attached_file': ''
        });
  }

  File? _video;
  final picker = ImagePicker();

// This funcion will helps you to pick a Video File

  File? image;

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().getImage(source: imageSource);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        // Navigator.pop(context);
        Common().toast('Image Successfully Submitted');
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  static Future<File?> pickFile(BuildContext context, List<String> type) async {
    List<String> s = type.map((e) => e.toLowerCase()).toList();
    try {
      FilePickerResult result = await (FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [...s],
      ) as FutureOr<FilePickerResult>);

      File file = File(result.files.single.path!);
      print(file.path);
      return file;
    } catch (e) {
      FlutterToastX.showErrorToastBottom(context, "Failed to pick file");
      return null;
    }
  }

  bool isAnyone = false;

  List<LineItemList> listOfLineItems = [];
  List<SeeStatus> listOfVisibility = [];

  String? selectedPostTypeString;
  String? selectedPostVisibilityString;
  String? selectedFileTypeString;
  File? selectedFile;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPostOptions();
      getData();
    });
  }

  String name = "", userImage = "", curUserId = "";

  getData() async {
    await App.init();
    setState(() {
      name = App.localStorage.getString("name")!;
      userImage = App.localStorage.getString("profile") ?? "";
      curUserId = App.localStorage.getString("user_id") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          title: text('Share Post',
              textColor: MyColorName.primaryDark,
              fontFamily: fontMedium,
              fontSize: 14.sp)),
      body: Column(
        children: [
          Card(
            elevation: 8,
            child: Container(
              margin: EdgeInsets.only(top: getWidth(20), bottom: getWidth(20)),
              padding: EdgeInsets.all(getWidth(20)),
              decoration: boxDecoration(
                radius: 30,
                bgColor: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                      contentPadding: const EdgeInsets.all(1),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100), child: commonImage(userImage, 100.0, 100.0, "", context, "")),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(name, textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 12.sp),
                                GestureDetector(
                                  onTap: () {
                                    showPostVisibilityBottomSheet(null);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: text(selectedPostVisibilityString ?? "Select Visibility",
                                        textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                          boxWidth(10),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          createPostOptions();
                        },
                        child: Container(
                          height: 3.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: const Center(child: Text("Post")),
                        ),
                      )),
                  boxHeight(10),
                  Container(
                    height: 30.h,
                    color: Colors.white,
                    child: TextField(
                      controller: desc,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      style: textStyle14px500w,
                      decoration: new InputDecoration.collapsed(hintText: 'What do you want to talk about ?'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Card(
            elevation: 8,
            child: Container(
              child: Row(
                children: [
                  Spacer(),
                  Text(selectedFileTypeString ?? "Add Attachments", style: textStyle14px500w),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showAttachmentOptions();
                    },
                    icon: Icon(Icons.attach_file),
                    color: Colors.black.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showPostItemBottomSheet(String? bookingNo) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  text("Choose type of post", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
                  text("Please select the type of post you are trying to post",
                      textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp),
                  ...listOfLineItems.map((e) => InkWell(
                        onTap: () {
                          selectedPostTypeString = e.feedCategoryId;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              commonImage(e.imagesPath, 40.0, 40.0, "", context, ""),
                              horizontalSpace(10.0),
                              text(e.feedCategoryTitle ?? "N/A", textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 12.sp),
                            ],
                          ),
                        ),
                      )),
                  verticalSpace(20.0),
                ],
              ),
            )
          ]);
        });
  }

  void showPostVisibilityBottomSheet(String? bookingNo) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  text("Who can see this post?", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
                  text("Your post will be visible on feed, on your profile and in search results",
                      textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 10.sp),
                  ...listOfVisibility.map((e) => InkWell(
                        onTap: () {
                          selectedPostVisibilityString = e.typeTitle;
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              horizontalSpace(20.0),
                              text(e.typeTitle ?? "N/A", textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 12.sp),
                            ],
                          ),
                        ),
                      )),
                  verticalSpace(20.0),
                ],
              ),
            )
          ]);
        });
  }

  Future<void> getPostOptions() async {
    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Dialogs.showLoader(context, "Getting post type ...");
    PostLineItemBottomSheetResponse response = await apiController.get<PostLineItemBottomSheetResponse>(EndPoints.LINE_ITEM_POST);

    //hide loader
    await Dialogs.hideLoader(context);
    if (response.status ?? false) {
      listOfVisibility.clear();
      listOfLineItems.clear();
      listOfLineItems.addAll(response.list ?? []);
      listOfVisibility.addAll(response.seeStatus ?? []);
      if (listOfVisibility.isNotEmpty) selectedPostVisibilityString = listOfVisibility.first.typeTitle;

      showPostItemBottomSheet(null);

      //Update UI
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }
  }

  Future<void> createPostOptions() async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));
    print(selectedPostTypeString);
    print(selectedPostVisibilityString);

    Map<String, dynamic> body = {
      "user_id": curUserId,
      "feed_category_id": selectedPostTypeString,
      "see_your_post": listOfVisibility.firstWhere((element) => element.typeTitle == selectedPostVisibilityString).id,
      "description": desc.text.toString(),
      "add_content_type": getFileType(),
      "content_attached_file": selectedFileTypeString == null ? "" : await MultipartFile.fromFile(selectedFile?.path ?? "", filename: "attachments${DateTime.now().millisecond}.${geFileExtention()}"),
    };

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Creating post ...");
    PostCreatedResponse response = await apiController.post<PostCreatedResponse>(EndPoints.CREATE_POST, body: formData);

    //hide loader
    await Dialogs.hideLoader(context);
    if (response.status ?? false) {
      FlutterToastX.showSuccessToastBottom(context, "Your post is being published");

      //Update UI
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Navigator.pop(context);
      });
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }
  }

  void showAttachmentOptions() {
    List<String> attachmentTypeList = [];

    if (selectedPostTypeString == "1" || selectedPostTypeString == "2") {
      attachmentTypeList.addAll(["Photo", "File"]);
    }

    if (selectedPostTypeString == "3" || selectedPostTypeString == "4") {
      attachmentTypeList.addAll(["Video"]);
    }




    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select attachment type", style: textStyle14px600w),
                      verticalSpace(10.0),

                      ...attachmentTypeList.map((e) {
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
            ],
          ),
        );
      },
    ).then((value) async {
      selectedFileTypeString = value;

      var videoExt = ["WEBM", "MPG", "MP2", "MPEG", "MPE", "MPV", "OGG", "MP4", "M4P", "M4V", "AVI", "WMV", "MOV", "QT", "FLV", "SWF", "AVCHD"];
      if (value == "Video") {
        selectedFile = await pickFile(context, videoExt);
      } else if (value == "File") {
        selectedFile = await pickFile(context, ["doc", "docx", "html", "htm", "odt", "pdf", "xls", "xlsx", "ods", "ppt", "pptx", "txt"]);
      } else if (value == "Photo") {
        selectedFile = await pickFile(context, ["jpg", "png"]);
      }

      if (selectedFile == null) selectedFileTypeString = null;

      setState(() {});
    });
  }

  //1-Only Text,2-Image,3-Video,4-File
  int getFileType() {
    if (selectedFileTypeString == "Video") {
      return 3;
    } else if (selectedFileTypeString == "File") {
      return 4;
    } else if (selectedFileTypeString == "Photo") {
      return 2;
    } else {
      return 1; //Text
    }
  }

  String geFileExtention() {
    String path = selectedFile?.path ?? "";
    if (path.isNotEmpty) {
      path = path.split('').reversed.join('');
      String ext = path.split('.').first;
      ext = ext.split('').reversed.join('');
      print("file extension $ext");
      return ext;
    }
    return "";
  }
}
