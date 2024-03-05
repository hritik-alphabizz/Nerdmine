import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/job_and_applicants_response.dart';
import 'package:nerdmine/screen/job_detail.dart';
import 'package:nerdmine/screen/post_job.dart';
import 'package:nerdmine/screen/profile_screen.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/screen/user_info_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../model/job_model.dart';

class ViewPostJobSearch extends StatefulWidget {
  const ViewPostJobSearch({Key? key}) : super(key: key);

  @override
  State<ViewPostJobSearch> createState() => _ViewPostJobSearchState();
}

class _ViewPostJobSearchState extends State<ViewPostJobSearch> {
  List<JobModel> listOfGovJob = [];
  List<JobModel> listOfPvtJob = [];
  List<UserApplyList> listOfAppliedJob = [];
  List<JobModel> currentTabJobs = [];

  int govJob = 1;
  int pvtJob = 2;
  int applicants = 3;

  int currentTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTab = govJob;
    getJobs();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

  getJobs() async {
    listOfGovJob.clear();
    listOfPvtJob.clear();
    listOfAppliedJob.clear();

    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + "jobListRecruiterORCompany/$curUserId"));
    if (response['status']) {
      setState(() => loading = false);
      JobAndApplicantsResponse jobAndApplicantsResponse = JobAndApplicantsResponse.fromJson(response);

      for (JobList v in jobAndApplicantsResponse.jobList ?? []) {
        if (v.jobType == "Government job") {
          listOfGovJob.add(JobModel.fromJson(v.toJson()));
        }
        if (v.jobType == "Private job") {
          listOfPvtJob.add(JobModel.fromJson(v.toJson()));
        }
      }
      listOfAppliedJob = jobAndApplicantsResponse.userApplyList??[];
    }
    currentTabJobs = listOfGovJob;
    currentTab = govJob;
    setState(() => loading = false);
  }

  bool isNetwork = false;
  bool saved = false;

  savedJob(id) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "item_id": id,
          "item_type": "1",
        };
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "addItemInWishlist"), data);
        print(response);
        bool status = true;
        setState(() {
          saved = false;
        });
        if (response['status']) {
        } else {}
        String msg = response['msg'];
        setSnackbar(msg, context);
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
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              PageTransition(child: PostJobScreen(), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 300)),
            );

            getJobs();
          },
          backgroundColor: MyColorName.primaryDark,
          child: Padding(
            padding: EdgeInsets.all(getWidth(20)),
            child: Image.asset("images/add.png"),
          )),
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
        title: text("Job search".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
        actions: [
          InkWell(
            onTap: () {
              navigateScreen(context, SearchScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/search.png")),
            ),
          ),
          Container(
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(15)),
            child: Center(child: Image.asset("images/menu.png")),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          children: [
            boxHeight(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = govJob;
                        currentTabJobs = listOfGovJob;
                        // tempJob = govtJob.toList();
                      });
                    },
                    child: Container(
                      height: getHeight(90),
                      decoration: boxDecoration(
                        bgColor: MyColorName.colorBg1,
                        radius: 48.sp,
                        color: currentTab == govJob ? MyColorName.primaryLite : Color(0xff707070),
                      ),
                      child: Center(
                        child: text("Gov job",
                            textColor: currentTab == govJob ? MyColorName.primaryLite : MyColorName.colorTextPrimary,
                            fontFamily: fontRegular,
                            isLongText: true,
                            fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
                boxWidth(20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = pvtJob;
                        currentTabJobs = listOfPvtJob;
                      });
                    },
                    child: Container(
                      height: getHeight(90),
                      decoration: boxDecoration(
                        bgColor: MyColorName.colorBg1,
                        radius: 48.sp,
                        color: currentTab == pvtJob ? MyColorName.primaryLite : Color(0xff707070),
                      ),
                      child: Center(
                        child: text("Private job",
                            textColor: currentTab == pvtJob ? MyColorName.primaryLite : MyColorName.colorTextPrimary,
                            fontFamily: fontRegular,
                            isLongText: true,
                            fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
                boxWidth(20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = applicants;
                        // currentTabJobs = applicants;
// tempJob = privateJob.toList();
                      });
                    },
                    child: Container(
                      height: getHeight(90),
                      decoration: boxDecoration(
                        bgColor: MyColorName.colorBg1,
                        radius: 48.sp,
                        color: currentTab == applicants ? MyColorName.primaryLite : Color(0xff707070),
                      ),
                      child: Center(
                        child: text("Applicants",
                            textColor: currentTab == applicants ? MyColorName.primaryLite : MyColorName.colorTextPrimary,
                            fontFamily: fontRegular,
                            isLongText: true,
                            fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selected = false;
            //             // listOfAppliedJob = listOfAppliedJob.toList();
            //             currentTabJobs = listOfPostedJob.toList();
            //           });
            //         },
            //         child: Container(
            //           height: getHeight(90),
            //           decoration: boxDecoration(
            //             bgColor: MyColorName.colorBg1,
            //             radius: 48.sp,
            //             color: !selected ? MyColorName.primaryLite : Color(0xff707070),
            //           ),
            //           child: Center(
            //             child: text("Job Posted",
            //                 textColor: !selected ? MyColorName.primaryLite : MyColorName.colorTextPrimary,
            //                 fontFamily: fontRegular,
            //                 isLongText: true,
            //                 fontSize: 12.sp),
            //           ),
            //         ),
            //       ),
            //     ),
            //     boxWidth(20),
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selected = true;
            //             // tempJob = postedJobList.toList();
            //             currentTabJobs = listOfAppliedJob.toList();
            //           });
            //         },
            //         child: Container(
            //           height: getHeight(90),
            //           decoration: boxDecoration(
            //             bgColor: MyColorName.colorBg1,
            //             radius: 48.sp,
            //             color: selected ? MyColorName.primaryLite : Color(0xff707070),
            //           ),
            //           child: Center(
            //             child: text("Job Applications",
            //                 textColor: selected ? MyColorName.primaryLite : MyColorName.colorTextPrimary,
            //                 fontFamily: fontRegular,
            //                 isLongText: true,
            //                 fontSize: 12.sp),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            boxHeight(30),

            if (currentTab == pvtJob || currentTab == govJob)
              Expanded(
                child: !loading
                    ? ListView.separated(
                        itemCount: currentTabJobs.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return boxHeight(20);
                        },
                        itemBuilder: (context, index) {
                          JobModel jobModel = currentTabJobs[index];
                          return InkWell(
                            onTap: () {
                              navigateScreen(context, JobDetailScreen(jobModel.jobId.toString()));
                            },
                            child: Container(
                              decoration: boxDecoration(radius: 10, bgColor: MyColorName.colorBg1),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: commonImage(jobModel.companyLogo, 136.0, 136.0, "", context, "")),
                                  boxWidth(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        text(getString(jobModel.jobTitle ?? ""),
                                            textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                                        boxHeight(5),
                                        text(getString(jobModel.companyName ?? ""),
                                            textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                        boxHeight(5),
                                        text(getString(jobModel.location ?? ""),
                                            textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                        boxHeight(5),
                                        /*    Row(
                                    children: [
                                      Image.asset("images/user.png",width: getWidth(30),height: getHeight(30),),
                                      boxWidth(5),
                                      text("Your profile match this job",textColor: Color(0xff5e5e5e),fontFamily: fontRegular,fontSize: 7.5.sp),
                                    ],
                                  ),*/
                                        boxHeight(10),
                                        text(getDuration(jobModel.createDate ?? ""),
                                            textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 7.sp),
                                      ],
                                    ),
                                  ),
                                  boxWidth(10),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          jobModel.addWishlistStatus = "1";
                                        });
                                        savedJob(currentTabJobs[index].jobId);
                                      },
                                      child: Image.asset(
                                        "images/bookmark.png",
                                        height: getHeight(40),
                                        width: getHeight(30),
                                        fit: BoxFit.fill,
                                        color: currentTabJobs[index].addWishlistStatus == "1" ? Colors.red : Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(
                          color: MyColorName.primaryDark,
                        ),
                      ),
              ),
            if (currentTab == applicants)
              Expanded(
                child:  ListView.separated(
                    itemCount: listOfAppliedJob.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return boxHeight(20);
                    },
                    itemBuilder: (context, index) {
                      UserApplyList model = listOfAppliedJob[index];
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: MyColorName.colorBg1,
                        contentPadding: EdgeInsets.all(10),
                        leading: InkWell(
                          onTap: () {
                            String userId = App.localStorage.getString("user_id") ?? "";

                            if (userId == model.userId) {
                              navigateScreen(context, ProfileScreen());
                            } else {
                              navigateScreen(context, UserProfileScreen(model.userId ?? ""));
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: commonImage(model.profileImage, 100.0, 100.0, "", context, ""),
                          ),
                        ),
                        title: text(getString(model.name.toString()), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              text(getString(model.applyDate.toString()), textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                            // Row(
                            //   children: [
                            //     Image.asset(
                            //       "images/mutual.png",
                            //       width: getWidth(30),
                            //       height: getHeight(30),
                            //     ),
                            //     text("7 Mutual connections", textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                            //   ],
                            // ),
                          ],
                        ),
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
