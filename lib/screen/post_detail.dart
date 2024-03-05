import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/comment_model.dart';
import 'package:nerdmine/model/feed_menu_options.dart';
import 'package:nerdmine/model/feed_model.dart';
import 'package:nerdmine/res/Fonts.dart';
import 'package:nerdmine/screen/home_screen.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/flutter_toast.dart';
import 'package:nerdmine/utils/progress_dialog.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/ApiBaseHelper.dart';

class PostDetail extends StatefulWidget {
  FeedModel model;
  List<FeedOption> option;

  PostDetail(this.model, this.option);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool obscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComment();
  }
  List<CommentModel> commentList = [];
  getComment()async{
    Map response = await apiBase.getAPICall(Uri.parse(baseUrl+"feedDetails/${widget.model.feedId}"));
    if(response['status']){
      setState(() {
        commentList.clear();
        loading = false;

      });
      for(var v in response['info']['comments_list']){
        commentList.add(CommentModel.fromJson(v));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context, widget.model);
        return Future.value();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffF2F4F8),
        appBar: AppBar(
          centerTitle: true,
          leading:  InkWell(
            onTap: (){
              Navigator.pop(context, widget.model);
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
              "Post Detail".toString(),
              textColor: MyColorName.primaryDark,fontFamily: fontMedium,fontSize: 14.sp
          ),
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

     /*       Container(
              margin: EdgeInsets.all(getWidth(10)),
              padding: EdgeInsets.all(getHeight(15)),
              child: Center(child: Image.asset("images/menu.png")),
            ),*/
          ],
        ),

        body: Container(
          child: ListView(
            children: [
              Container(
                decoration: boxDecoration(
                  bgColor: Colors.white,
                  showShadow: true,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(1),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: commonImage(widget.model.userProfileImage,
                              100.0, 100.0, "", context, "")),
                      title: Row(
                        children: [
                          text(getString(widget.model.userName!), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                          boxWidth(10),
                          text(getDuration(widget.model.postDate!), textColor: Colors.black, fontFamily: fontMedium, fontSize: 7.sp),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () {
                          showPostBottomSheet(widget.model.feedId ?? "", widget.model.sharedLink);
                        },
                        child: Image.asset(
                          "images/menu.png",
                          width: getWidth(40),
                          height: getHeight(30),
                        ),
                      ),
                      subtitle: text(getString(widget.model.userType!), textColor: Color(0xff6D6D6D), fontFamily: fontMedium, fontSize: 10.sp),
                    ),

                    ReadMore(model: widget.model),

                    if (widget.model.addContentType == "4")
                      InkWell(
                        onTap: () {
                          launchUrl(Uri.parse("${widget.model?.contentAttachedFilePath ?? ""}"), mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text('Attachment', style: textStyle14px500w),
                              horizontalSpace(5.0),
                              Icon(Icons.download_for_offline, color: Colors.black.withOpacity(0.6)),
                            ],
                          ),
                        ),
                      ),
                    boxHeight(10),
                    if (widget.model.feedCategoryId == "3" && (widget.model.contentAttachedFile?.isNotEmpty ?? false) && widget.model.addContentType != "4")
                      Container(height: 250.0, child: VideoApp(widget.model.contentAttachedFilePath ?? "")),
                    boxHeight(10),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        widget.model.contentAttachedFilePath != null &&
                            widget.model.contentAttachedFilePath != ""
                            ? commonHWImage(
                            widget.model.contentAttachedFilePath,
                            "",
                            context,
                            "")
                            : SizedBox(),
                        Container(
                          height: getHeight(82),
                          width: getWidth(720),
                          padding: EdgeInsets.all(getWidth(30)),
                          decoration: BoxDecoration(
                              color: MyColorName.primaryDark
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              )),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (!(widget.model.likedStatus!=null&&widget.model.likedStatus=="1")) likeFeed(widget.model.feedId);
                                    else dislikeFeed(widget.model.feedId);
                                  },
                                  child:
                                  Image.asset("images/like.png",color: widget.model.likedStatus!=null&&widget.model.likedStatus=="1"?Colors.red:Colors.white,)),
                              boxWidth(10),
                              text(widget.model.totalLikes!,
                                  textColor: MyColorName.colorBg1,
                                  fontFamily: fontMedium,
                                  fontSize: 10.sp),
                              boxWidth(10),
                              InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                      "images/comment.png")),
                              boxWidth(10),
                              text(widget.model.totalComments!,
                                  textColor: MyColorName.colorBg1,
                                  fontFamily: fontMedium,
                                  fontSize: 10.sp),
                              boxWidth(10),
                              Image.asset("images/share.png"),
                              boxWidth(10),
                              text(widget.model.totalShared!,
                                  textColor: MyColorName.colorBg1,
                                  fontFamily: fontMedium,
                                  fontSize: 10.sp),
                              Spacer(),
                              InkWell(
                                  onTap: () async {
                                    await FlutterShare.share(
                                        title: 'Example share',
                                        text: 'Share',
                                        linkUrl: widget.model.sharedLink,
                                        chooserTitle: 'Share');
                                  },
                                  child: Image.asset("images/send.png")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              boxHeight(30),
               !loading?ListView.builder(
                   itemCount: commentList.length,
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context,index){
                     CommentModel commentModel = commentList[index];
                 return Container(
                   padding: EdgeInsets.all(getWidth(30)),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       ClipRRect(
                           borderRadius: BorderRadius.circular(100),
                           child: commonImage(commentModel.userProfileImage,
                               80.0, 80.0, "", context, "")),
                       boxWidth(20),
                       Expanded(
                         child: Container(
                           decoration: boxDecoration(
                             radius: 8.0,
                             bgColor: Colors.white
                           ),
                           padding: EdgeInsets.all(getWidth(20)),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   text(getString(commentModel.userName!),
                                       textColor: MyColorName.primaryDark,
                                       fontFamily: fontMedium,
                                       fontSize: 10.sp),
                                   boxWidth(10),
                                   text(getDuration(commentModel.commentDate!),
                                       textColor: Colors.black,
                                       fontFamily: fontMedium,
                                       fontSize: 7.sp),
                                 ],
                               ),
                               text(getString(commentModel.userType!),
                                   textColor: Color(0xff6D6D6D),
                                   fontFamily: fontMedium,
                                   fontSize: 8.sp),
                               boxHeight(10),
                               text(getString(commentModel.comments!),
                                   textColor: Color(0xff6D6D6D),
                                   fontFamily: fontMedium,
                                   fontSize: 10.sp),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 );
               }):SizedBox(),
              boxHeight(150),
            ],
          ),
        ),
        bottomSheet:
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(getWidth(30)),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: commentCon,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                ),
                filled: true,
                counterText: '',
                suffixIcon: InkWell(
                  onTap: (){
                    if(commentCon.text==""){
                      return;
                    }
                    setState(() {
                      comment  = true;
                    });
                    addComment(widget.model.feedId);
                  },
                  child: Container(
                    padding: EdgeInsets.all(getWidth(20)),
                    child: !comment?Image.asset(Assets.imagesSend,
                      height: getWidth(29),
                      width: getWidth(29), fit: BoxFit.fill,
                      color: MyColorName.primaryDark,
                    ):CircularProgressIndicator(color:  MyColorName.primaryDark,),

                  ),
                ),
                contentPadding: EdgeInsets.all(getWidth(30)),
                hintText: "write your comment here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(color:MyColorName.colorTextSecondary.withOpacity(0.2) ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  TextEditingController commentCon = new TextEditingController();
  String? userType;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  bool comment = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();

  likeFeed(id) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "feed_id": id,
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "feedLike"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          setState(() {
            widget.model.totalLikes = response['total_like'];
            widget.model.likedStatus = "1";
          });
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


  dislikeFeed(id) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "feed_id": id,
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "feedDislike"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          setState(() {
            widget.model.totalLikes = response['total_like'];
            widget.model.likedStatus = "2";
          });
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


  addComment(id) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    // e.g. "Moto G (4)"
    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "feed_id": id,
          "comments":commentCon.text
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "feedComment"), data);
        print(response);
        bool status = true;
        setState(() {
          comment = false;
        });
        if (response['status']) {
          setState(() {
            commentCon.text = "";
            widget.model.totalComments = response['total_comments'];
            loading = true;
          });
          getComment();
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

  updateFeedOptionAction(String feedId, feedOptionId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "feed_id": feedId,
          "feed_option_id": feedOptionId,
        };
        Dialogs.showLoader(context, "Updating response please wait");
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "feedOptionAction"), data);
        print(response);
        Dialogs.hideLoader(context);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          await Future.delayed(Duration(milliseconds: 400));
          FlutterToastX.showSuccessToastBottom(context, response['msg']);
          Navigator.pop(context);
        } else {
          FlutterToastX.showErrorToastBottom(context, response['msg']);
        }
        String msg = response['msg'];
        //setSnackbar(msg, context);
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

  void showPostBottomSheet(String feedId, link) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        isDismissible: false,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  ...widget.option.map((e) => InkWell(
                        onTap: () async {
                          // selectedPostTypeString = e.feedCategoryId;
                          print("Option ${e.feedOptionId}");
                          if (e.feedOptionId == "2") {
                            await FlutterShare.share(
                                title: 'Example share',
                                text: 'Share',
                                linkUrl:  link,
                                chooserTitle: 'Share');
                          } else {
                            updateFeedOptionAction(feedId, e.feedOptionId);
                          }
                          // Navigator.pop(context);
                          setState(() {});


                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              commonImage(e.icon, 30.0, 30.0, "", context, ""),
                              horizontalSpace(14.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(e.title ?? "N/A", textColor: MyColorName.colorTextPrimary, fontFamily: fontRegular, fontSize: 12.sp),
                                  if (e.description != null && e.description!.isNotEmpty)
                                    text("${e.description}", textColor: MyColorName.colorTextSecondary, fontFamily: fontRegular, fontSize: 8.sp),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  verticalSpace(20.0),
                ],
              ),
            )
          ]);
        }).then((value) {
      Navigator.pop(context);
    });
  }
}
