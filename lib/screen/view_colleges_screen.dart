import 'package:flutter/material.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/InstitutueResponse.dart';
import 'package:nerdmine/model/sub_cat_model.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/screen/page_info_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

import '../utils/constant.dart';

class ViewCollegeScreen extends StatefulWidget {
  final String cId, sId;

  ViewCollegeScreen(this.cId, this.sId);

  @override
  State<ViewCollegeScreen> createState() => _ViewCollegeScreenState();
}

class _ViewCollegeScreenState extends State<ViewCollegeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInstitutes();
    });
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

  getCategory() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + "coursesListByCategoryId/"));
    setState(() {
      loading = false;
    });
    if (response['status']) {
      for (var v in response['list']) {
        subCatList.add(SubCatModel.fromJson(v));
      }
      length = subCatList.length > 5 ? 5 : subCatList.length;
    }
  }

  int length = 0;
  List<SubCatModel> subCatList = [];

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
                Assets.imagesBack,
                fit: BoxFit.fill,
              )),
        ),
        backgroundColor: Color(0xffF2F4F8),
        elevation: 1,
        title: text("Institute", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
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
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: MyColorName.colorBg1,
              padding: EdgeInsets.all(getWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  text(listOfInstitutes.length > 0 ? "Top ${listOfInstitutes.length} Institute".toString() : "",
                      textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                  //  Image.asset("images/search.png",color: MyColorName.colorTextPrimary,width: getWidth(30),)
                ],
              ),
            ),
            boxHeight(30),
            !loading
                ? listOfInstitutes.length > 0
                    ? Expanded(
                        child: Container(
                          child: ListView.separated(
                              itemCount: listOfInstitutes.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return Container(height: 1.0, color: Colors.grey.withOpacity(0.3));
                              },
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    String? id = listOfInstitutes[index].pageId;
                                    navigateScreen(context, PageInfoScreen(id ?? ""));
                                  },
                                  tileColor: MyColorName.colorBg1,
                                  leading: commonImage(listOfInstitutes[index].coverPhoto, 50.0, 50.0, "", context, ""),
                                  title: text(listOfInstitutes[index].pageName!,
                                      textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                                );
                              }),
                        ),
                      )
                    : Center(
                        child: text("No Result Found", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            length != subCatList.length
                ? InkWell(
                    onTap: () {
                      setState(() {
                        length = subCatList.length;
                      });
                    },
                    child: Container(
                      width: getWidth(300),
                      height: getHeight(70),
                      decoration: boxDecoration(
                        bgColor: MyColorName.primaryLite,
                        radius: 48.sp,
                      ),
                      child: Center(
                        child: text("View all", textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, isLongText: true, fontSize: 12.sp),
                      ),
                    ),
                  )
                : SizedBox(),
            boxHeight(30),
          ],
        ),
      ),
    );
  }

  List<ListOfInstitues> listOfInstitutes = [];

  Future<void> getInstitutes() async {
    //delay prevent loader stuck
    await Future.delayed(Duration(milliseconds: 600));

    Map<String, dynamic> body = {"category_id": widget.cId, "sub_category_id": widget.sId};
    var formData = FormData.fromMap(body);
    loading = true;
    InstitutueResponse response = await apiController.post<InstitutueResponse>(EndPoints.INSTITUE_LIST, body: formData);

    //hide loader
    await Dialogs.hideLoader(context);
    if (response.status ?? false) {
      loading = false;
      listOfInstitutes.addAll(response.listOfInstitues ?? []);


    } else {
      loading = false;
      FlutterToastX.showErrorToastBottom(context, "Failed: ${response.msg ?? ""}");
    }
    //Update UI
    setState(() {});
  }
}
