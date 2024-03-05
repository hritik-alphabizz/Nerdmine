
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/wishlist_model.dart';
import 'package:nerdmine/screen/job_detail.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  bool selected = false;
  List<JobWishlist> tempJob = [];
  List<PostWishlist> tempPostWishList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobs();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

  getJobs() async {
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + "userWishlist/${curUserId}"));
    if (response['status']) {
      setState(() {
        tempJob.clear();
        loading = false;
      });
      WishlistModel wishlistModel = WishlistModel.fromJson(response);

      if (wishlistModel.mlist?.jobWishlist != null) {
        List<JobWishlist> s = wishlistModel.mlist!.jobWishlist!;
        for (var v in s) {
          tempJob.add(v);
        }
      }

      if (wishlistModel.mlist?.postWishlist != null) {
        List<PostWishlist> s = wishlistModel.mlist!.postWishlist!;
        for (var v in s) {
          tempPostWishList.add(v);
        }
      }
    }
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
          "item_type":"1",
        };
        Map response = await apiBaseHelper.getAPICall(
            Uri.parse(baseUrl + "removeItemFromWishlist/${id}"));
        print(response);
        bool status = true;
        setState(() {
          saved = false;
        });
        if (response['status']) {
          getJobs();
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
      appBar: AppBar(
        centerTitle: true,
        leading:  InkWell(
          onTap: (){
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
            "Saved Items".toString(),
            textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
        ),
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
         /* Container(
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(15)),
            child: Center(child: Image.asset("images/menu.png")),
          ),*/
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boxHeight(30),
              text("Saved Jobs".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
              boxHeight(30),
              !loading
                  ? ListView.separated(
                      itemCount: tempJob.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return boxHeight(20);
                      },
                      itemBuilder: (context, index) {
                        JobWishlist jwl = tempJob[index];
                        return InkWell(
                          onTap: () {
                            navigateScreen(context, JobDetailScreen(jwl.jobId.toString()));
                          },
                          child: Container(
                            decoration: boxDecoration(radius: 10, bgColor: MyColorName.colorBg1),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0), child: commonImage(jwl.companyLogo, 136.0, 136.0, "", context, "")),
                                boxWidth(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      text(getString(jwl.jobTitle ?? ""),
                                          textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                                      boxHeight(5),
                                      text(getString(jwl.companyName ?? ""), textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                      boxHeight(5),
                                      text(getString(jwl.location ?? ""), textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                      boxHeight(10),
                                      text(jwl.savedTime ?? "", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 7.sp),
                                    ],
                                  ),
                                ),
                                boxWidth(10),
                                InkWell(
                                    onTap: () {
                                      savedJob(jwl.wishlistId);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: MyColorName.primaryDark,
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
              boxHeight(10),
              if (tempPostWishList.isNotEmpty)
                text("Saved Posts".toString(), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 14.sp),
              if (tempPostWishList.isNotEmpty) boxHeight(30),
              if (tempPostWishList.isNotEmpty)
                !loading
                    ? ListView.separated(
                        itemCount: tempPostWishList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return boxHeight(20);
                        },
                        itemBuilder: (context, index) {
                          PostWishlist jwl = tempPostWishList[index];
                          return InkWell(
                            onTap: () {
                              navigateScreen(context, JobDetailScreen(jwl.feedId.toString()));
                            },
                            child: Container(
                              decoration: boxDecoration(radius: 10, bgColor: MyColorName.colorBg1),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: commonImage(jwl.userProfileImage, 136.0, 136.0, "", context, "")),
                                  boxWidth(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        text(getString(jwl.userName ?? ""),
                                            textColor: MyColorName.colorTextPrimary, fontFamily: fontMedium, fontSize: 10.sp),
                                        boxHeight(5),
                                        text(getString(jwl.description ?? ""),
                                            textColor: Color(0xff6D6D6D), fontFamily: fontRegular, fontSize: 7.5.sp),
                                        boxHeight(5),
                                      ],
                                    ),
                                  ),
                                  boxWidth(10),
                                  InkWell(
                                      onTap: () {
                                        savedJob(jwl.wishlistId);
                                      },
                                      child:  Icon(
                                        Icons.delete,
                                        color: MyColorName.primaryDark,
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
            ],
          ),
        ),
      ),
    );



  }
}
