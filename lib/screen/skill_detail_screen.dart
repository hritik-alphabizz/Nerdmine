import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:sizer/sizer.dart';

import '../api/api_controller_expo.dart';
import '../api/end_points.dart';
import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/flutter_toast.dart';
import '../utils/progress_dialog.dart';
import '../utils/widget.dart';

class SkillDetailScreen extends StatefulWidget {
  const SkillDetailScreen({Key? key}) : super(key: key);

  @override
  State<SkillDetailScreen> createState() => _SkillDetailScreenState();
}

class _SkillDetailScreenState extends State<SkillDetailScreen> {
  late String? userId, name, email, userProfileImage;

  List<Slist> listOfCategory = [];
  Slist? categoryString;

  @override
  void initState() {
    super.initState();

    userId = App.localStorage.getString("user_id");
    name = App.localStorage.getString("name");
    email = App.localStorage.getString("email");
    userProfileImage = App.localStorage.getString("profile");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSkillsDetails();
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
          title: text('Student Profile', textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp)),
      body: Column(
        children: [
          verticalSpace(20.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: listOfCategory
                  .map<Widget>(
                    (e) => InkWell(
                      onTap: () {
                        categoryString = e;
                        e.checked = !(e.checked ?? true);
                        // presenter.getTicketSubCategory(context, categoryString ?? "");
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: e.checked ? MyColorName.primaryLite : MyColorName.primaryDark, borderRadius: BorderRadius.circular(30.0)),
                        child: text("${e._skillsTitle}", textColor: MyColorName.colorTextFour, fontFamily: fontRegular, fontSize: 10.sp),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Spacer(),
          boxHeight(54),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade800, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999))),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  saveSkills();
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
          ),
          boxHeight(54),
        ],
      ),
    );
  }

  SkillListResponse? response;

  Future<void> getSkillsDetails() async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Map<String, dynamic> body = {"user_id": App.localStorage.getString("user_id")};

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Getting skills ...");
    response = await apiController.post<SkillListResponse>(EndPoints.ADD_SKILL_FORM_DATA, body: formData);

    listOfCategory.addAll(response?.list??[]);

    //hide loader
    await Dialogs.hideLoader(context);
    if (response?.status ?? false) {
      //Update UI

      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
    }
  }

  Future<void> saveSkills() async {
    // remove input focus
    FocusScope.of(context).unfocus();

    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    String commaSaperatedString = listOfCategory.where((element) => element.checked).map((e) => e._skillsId).join(",");

    if (commaSaperatedString.isEmpty) {
      FlutterToastX.showErrorToastBottom(context, "Please select at least one skill");
      return;
    }

    Map<String, dynamic> body = {
      "user_id": App.localStorage.getString("user_id"),
      "skills_id": commaSaperatedString,
    };

    var formData = FormData.fromMap(body);

    Dialogs.showLoader(context, "Getting skills ...");
    response = await apiController.post<SkillListResponse>(EndPoints.ADD_SKILLS, body: formData);

    //hide loader
    await Dialogs.hideLoader(context);
    if (response?.status ?? false) {
      //Update UI

      Navigator.pop(context);
      FlutterToastX.showSuccessToastBottom(context, response?.msg ?? "");
      setState(() {});
    } else {
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response?.msg ?? "Something went wrong"}");
    }
  }
}

/// status : true
/// msg : "Success"
/// list : [{"skills_id":"4","skills_title":"Django","status":"1"},{"skills_id":"5","skills_title":"Laravel","status":"1"},{"skills_id":"6","skills_title":"Codeigniter","status":"1"},{"skills_id":"7","skills_title":"CakePHP","status":"1"},{"skills_id":"8","skills_title":"Node Js","status":"1"},{"skills_id":"9","skills_title":"Express JS","status":"1"}]

class SkillListResponse {
  SkillListResponse({
    bool? status,
    String? msg,
    List<Slist>? list,
  }) {
    _status = status;
    _msg = msg;
    _slist = list;
  }

  SkillListResponse.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['list'] != null) {
      _slist = [];
      json['list'].forEach((v) {
        _slist?.add(Slist.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _msg;
  List<Slist>? _slist;

  SkillListResponse copyWith({
    bool? status,
    String? msg,
    List<Slist>? list,
  }) =>
      SkillListResponse(
        status: status ?? _status,
        msg: msg ?? _msg,
        list: list ?? _slist,
      );

  bool? get status => _status;

  String? get msg => _msg;

  List<Slist>? get list => _slist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_slist != null) {
      map['list'] = _slist?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// skills_id : "4"
/// skills_title : "Django"
/// status : "1"

class Slist {
  bool checked = false;

  Slist({
    String? skillsId,
    String? skillsTitle,
    String? status,
  }) {
    _skillsId = skillsId;
    _skillsTitle = skillsTitle;
    _status = status;
  }

  Slist.fromJson(dynamic json) {
    _skillsId = json['skills_id'];
    _skillsTitle = json['skills_title'];
    _status = json['status'];
  }

  String? _skillsId;
  String? _skillsTitle;
  String? _status;

  Slist copyWith({
    String? skillsId,
    String? skillsTitle,
    String? status,
  }) =>
      Slist(
        skillsId: skillsId ?? _skillsId,
        skillsTitle: skillsTitle ?? _skillsTitle,
        status: status ?? _status,
      );

  String? get skillsId => _skillsId;

  String? get skillsTitle => _skillsTitle;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['skills_id'] = _skillsId;
    map['skills_title'] = _skillsTitle;
    map['status'] = _status;
    return map;
  }
}
