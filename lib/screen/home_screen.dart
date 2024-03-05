import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:nerdmine/export.dart';
import 'package:nerdmine/model/feed_cat_model.dart';
import 'package:nerdmine/model/feed_menu_options.dart';
import 'package:nerdmine/model/feed_model.dart';
import 'package:nerdmine/res/Fonts.dart';
import 'package:nerdmine/screen/chat_screen.dart';
import 'package:nerdmine/screen/coach_screen.dart';
import 'package:nerdmine/screen/connection_screen.dart';
import 'package:nerdmine/screen/job_search.dart';
import 'package:nerdmine/screen/notification_screen.dart';
import 'package:nerdmine/screen/post_detail.dart';
import 'package:nerdmine/screen/profile_screen.dart';
import 'package:nerdmine/screen/search_screen.dart';
import 'package:nerdmine/screen/share_post.dart';
import 'package:nerdmine/screen/user_info_screen.dart';
import 'package:nerdmine/screen/view_post_job_search.dart';
import 'package:nerdmine/utils/ApiBaseHelper.dart';
import 'package:nerdmine/utils/Session.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/common.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/utility_helper.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? tabController;
  List<Tab> tabList = [];

  bool selected = false;
  List<FeedCatModel> tabList1 = [];
  List<FeedModel> feedList = [];
  List<FeedModel> tempFeed = [];
  List<FeedOption> feedMenuOptions = [];

  String? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFeeds("feedList/$curUserId");
    getFirebaseToken();
    callChat();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }


  getData()async{
    await App.init();
    setState((){
      // name = App.localStorage.getString("name")!;
      image = App.localStorage.getString("profile")!;
    });
  }

  getFirebaseToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print("firebase token $deviceToken");
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  bool loading = true;

  getFeeds(url) async {
    feedMenuOptions.clear();
    setState(() {
      loading = true;
    });
    Map response = await apiBaseHelper.getAPICall(Uri.parse(baseUrl + url));
    if (response['status']) {
      //on status successful
      List<FeedOption>? listOfFeedOptions = FeedMenuOptions.fromJson(response).feedOption;
      feedMenuOptions.addAll(listOfFeedOptions ?? []);

      setState(() {
        loading = false;
      });
      if (tabList1.length == 0) {
        tabList1.add(FeedCatModel(feedCategoryId: "0", feedCategoryTitle: "All"));
        tabList.add(Tab(
          text: "All",
        ));
        for (var v in response['header_option']) {
          tabList1.add(FeedCatModel.fromJson(v));
          tabList.add(Tab(
            text: v['feed_category_title'],
          ));
        }
        tabController = new TabController(length: tabList.length, vsync: this);
      }

      for (var v in response['list']) {
        feedList.add(FeedModel.fromJson(v));
      }

      setState(() {});
    }
  }

  bool isNetwork = false;

  likeFeed(id, index) async {
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
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "feedLike"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          setState(() {
            feedList[index].totalLikes = response['total_like'];
            feedList[index].likedStatus = "1";
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

  dislikeFeed(id, index) async {
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
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "feedDislike"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
          setState(() {
            feedList[index].totalLikes = response['total_like'];
            feedList[index].likedStatus = "2";
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
                context,
                PageTransition(
                  child: ProfileScreen(),
                  type: PageTransitionType.bottomToTop,
                  duration: Duration(milliseconds: 300),
                ));
            image = App.localStorage.getString("profile")!;
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.all(getWidth(10)),
            padding: EdgeInsets.all(getHeight(4)),
            child: ClipRRect(borderRadius: BorderRadius.circular(100), child: commonImage(image, 100.0, 100.0, "", context, "")),
          ),
        ),
        title: Container(
          height: getHeight(60),
          width: getWidth(200),
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "images/blue_logo1.png",
            width: getWidth(200),
            fit: BoxFit.fill,
          ),
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
              margin: EdgeInsets.all(getWidth(15)),
              padding: EdgeInsets.all(getHeight(16)),
              child: Center(child: Image.asset("images/search.png")),
            ),
          ),
          InkWell(
            onTap: () {
              navigateScreen(context, ChatListScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(15)),
              padding: EdgeInsets.all(getHeight(16)),
              child: Center(child: Image.asset("images/msg.png")),
            ),
          ),
          InkWell(
            onTap: () {
              navigateScreen(context, NotificationScreen());
            },
            child: Container(
              decoration: boxDecoration(
                bgColor: MyColorName.primaryDark,
                radius: 100,
              ),
              margin: EdgeInsets.all(getWidth(15)),
              padding: EdgeInsets.all(getHeight(16)),
              child: Center(child: Image.asset("images/notify.png")),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(100.w, getHeight(85)),
          child: tabController != null
              ? Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: TabBar(
                    controller: tabController,
                    indicatorWeight: 4,
                    isScrollable: true,
                    // labelPadding: EdgeInsets.all(getWidth(1)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(borderRadius: BorderRadius.circular(30), color: MyColorName.primaryDark.withOpacity(0.3)),
                    labelStyle: TextStyle(
                      fontSize: 9.sp,
                      fontFamily: fontBold,
                    ),
                    labelColor: MyColorName.primaryDark,
                    unselectedLabelColor: MyColorName.primaryDark,
                    onTap: (index) {
                      setState(() {
                        loading = true;
                        tabController!.index = index;
                        feedList.clear();
                      });
                      if (index == 0) {
                        getFeeds("feedList/$curUserId");
                      } else {
                        getFeeds("filteredFeedList/${tabList1[index].feedCategoryId}");
                      }
                    },
                    tabs: tabList,
                  ),
                )
              : SizedBox(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {

          getFeeds("feedList/$curUserId");
          getFirebaseToken();
          callChat();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getData();
          });
          return Future(() => null);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(40)),
          child: !loading
              ? feedList.length > 0
                  ? ListView.builder(
                      itemCount: feedList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        FeedModel model = feedList[index];
                        return InkWell(
                          onTap: () async {
                            selectedIndex = index;
                            var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetail(model, feedMenuOptions)));
                            if (result != null) {
                              setState(() {
                                feedList[selectedIndex] = result;
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: getWidth(20), bottom: getWidth(20)),
                            padding: EdgeInsets.all(getWidth(20)),
                            decoration: boxDecoration(radius: 30, bgColor: Colors.white, showShadow: true),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.all(1),
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
                                      child: commonImage(model.userProfileImage, 100.0, 100.0, "", context, ""),
                                    ),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      showPostBottomSheet(model.feedId ?? "", model.sharedLink ?? "");
                                    },
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      padding: EdgeInsets.all(10),
                                      child: Image.asset(
                                        "images/menu.png",
                                        width: getWidth(30),
                                        height: getHeight(30),
                                      ),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(child: text(getString(model.userName!), textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp)),
                                      boxWidth(10),
                                      text(getDuration(model.postDate!), textColor: Colors.black, fontFamily: fontMedium, fontSize: 7.sp),
                                    ],
                                  ),
                                  subtitle: text(getString(model?.userType??""), textColor: Color(0xff6D6D6D), fontFamily: fontMedium, fontSize: 10.sp),
                                ),
                                ReadMore(model: model),
                                if (model.addContentType == "4")
                                  InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse("${model?.contentAttachedFilePath ?? ""}"), mode: LaunchMode.externalApplication);
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
                                if (model.feedCategoryId == "3" && (model.contentAttachedFile?.isNotEmpty ?? false) && model.addContentType != "4")
                                  Container(height: 250.0, child: VideoApp(feedList[selectedIndex].contentAttachedFilePath ?? "")),
                                boxHeight(10),
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    model.contentAttachedFilePath != null && model.contentAttachedFilePath != ""
                                        ? commonHWImage2(model.contentAttachedFilePath, "", context, "")
                                        : SizedBox(),
                                    Container(
                                      height: getHeight(82),
                                      width: getWidth(720),
                                      padding: EdgeInsets.all(getWidth(30)),
                                      decoration: BoxDecoration(
                                          color: MyColorName.primaryDark.withOpacity(0.6),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          )),
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (!(model.likedStatus != null && model.likedStatus == "1"))
                                                  likeFeed(model.feedId, index);
                                                else
                                                  dislikeFeed(model.feedId, index);
                                              },
                                              child: Image.asset(
                                                "images/like.png",
                                                color: model.likedStatus != null && model.likedStatus == "1" ? Colors.red : Colors.white,
                                              )),
                                          boxWidth(10),
                                          text(model.totalLikes!, textColor: MyColorName.colorBg1, fontFamily: fontMedium, fontSize: 10.sp),
                                          boxWidth(10),
                                          InkWell(onTap: () {}, child: Image.asset("images/comment.png")),
                                          boxWidth(10),
                                          text(model.totalComments!, textColor: MyColorName.colorBg1, fontFamily: fontMedium, fontSize: 10.sp),
                                          boxWidth(10),
                                          Image.asset("images/share.png"),
                                          boxWidth(10),
                                          text(model.totalShared!, textColor: MyColorName.colorBg1, fontFamily: fontMedium, fontSize: 10.sp),
                                          Spacer(),
                                          InkWell(
                                              onTap: () async {
                                                await FlutterShare.share(
                                                    title: 'Example share',
                                                    text: 'Share',
                                                    linkUrl: feedList[selectedIndex].sharedLink,
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
                        );
                      })
                  : Center(
                      child: text("No Result Found", textColor: MyColorName.primaryDark, fontFamily: fontMedium, fontSize: 10.sp),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () async {
          await Navigator.push(
              context, PageTransition(child: SharePost(), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 300)));
          setState(() {
            loading = true;
            tabController!.index = 0;
            feedList.clear();
          });

          getFeeds("feedList/$curUserId");
        },
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: MyColorName.primaryDark, shape: BoxShape.circle),
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.all(getWidth(20)),
          child: Image.asset("images/add.png"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                rowItem("Home", "images/home.png", 1),
                rowItem("Coach", "images/coach.png", 2),
                Container(
                  padding: EdgeInsets.all(getWidth(10)),
                  height: getHeight(70),
                  alignment: Alignment.bottomCenter,
                  child: text("Post".toString().toUpperCase(), textColor: MyColorName.primaryDark, fontFamily: fontRegular, fontSize: 8.sp),
                ),
                rowItem("Connection", "images/link.png", 4),
                rowItem("Jobs", "images/bag.png", 5),

                // rowItem("Post Jobs", "images/bag.png", 6),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector rowItem(title, image, pos) {
    return GestureDetector(
      onTap: () {
        if (pos == 2) {
          navigateScreen(context, CoachScreen());
        } else if (pos == 4) {
          navigateScreen(context, ConnectionScreen());
        } else if (pos == 5) {
          print("user type id  ${App.localStorage.getString("user_type_id")}");
          if (App.localStorage.getString("user_type_id") == "6" || App.localStorage.getString("user_type_id") == "7") {
            navigateScreen(context, ViewPostJobSearch());
          } else {
            navigateScreen(context, JobSearch());
          }
        }
      },
      child: SizedBox(
        height: getHeight(102),
        width: getWidth(145),
        child: Column(
          children: [
            boxHeight(10),
            Container(
                decoration:
                    boxDecoration(bgColor: MyColorName.primaryDark, radius: 100, color: pos == 1 ? MyColorName.primaryLite : MyColorName.primaryDark),
                padding: EdgeInsets.all(getWidth(20)),
                height: getHeight(60),
                width: getHeight(60),
                child: Image.asset(image)),
            text(title.toString().toUpperCase(),
                textColor: pos == 1 ? MyColorName.primaryLite : MyColorName.primaryDark, fontFamily: fontRegular, fontSize: 8.sp),
            boxHeight(5),
          ],
        ),
      ),
    );
  }

  callChat() async {
    await App.init();
    String name = App.localStorage.getString("name")!;
    String email = App.localStorage.getString("email")!;
    try {
      UserCredential data = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: "12345678",
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name.toString(),
          id: data.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${name.toString()}',
          lastName: "",
        ),
      );
      updateFuid(data.user!.uid);
      print(data.user!.uid);
    } catch (e) {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(),
        password: "12345678",
      );
      // App.localStorage.setString("firebaseUid", credential.user!.uid);
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name.toString(),
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${name.toString()}',
          lastName: "",
        ),
      );
      updateFuid(credential.user!.uid);
      print(e.toString());
    }
  }

  updateFuid(id) async {
    await App.init();
    isNetwork = await isNetworkAvailable();

    // e.g. "Moto G (4)"

    if (isNetwork) {
      try {
        Map data;
        data = {
          "user_id": curUserId,
          "FCId": id,
        };
        Map response = await apiBaseHelper.postAPICall(Uri.parse(baseUrl + "addFCId"), data);
        print(response);
        bool status = true;
        setState(() {
          loading = false;
        });
        if (response['status']) {
        } else {}
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

                  ...feedMenuOptions.map((e) => InkWell(
                    onTap: () async {
                          // selectedPostTypeString = e.feedCategoryId;
                          print("Option ${e.feedOptionId}");
                          if (e.feedOptionId == "2") {
                            await FlutterShare.share(title: 'Example share', text: 'Share', linkUrl: link, chooserTitle: 'Share');
                          } else {
                            updateFeedOptionAction(feedId, e.feedOptionId);
                          }
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
      getFeeds("feedList/$curUserId");
    });
  }
}

class ReadMore extends StatefulWidget {
  const ReadMore({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FeedModel model;

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  bool isReadMoreChecked = false;

  @override
  Widget build(BuildContext context) {
    return (widget.model.description ?? "").length > 60
        ? RichText(
            text: TextSpan(
              // text: readMore ? getString(widget.model.description!.substring(0, 60) + "...") : getString(widget.model.description!),
              text: isReadMoreChecked
                  ? getString(widget.model.description!)
                  : getString(widget.model.description!
                          .substring(0, (widget.model.description ?? "").length > 60 ? 60 : (widget.model.description ?? "").length) +
                      "..."),
              style: TextStyle(
                fontFamily: fontRegular,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: MyColorName.colorTextPrimary,
              ),
              children: [
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      isReadMoreChecked = !isReadMoreChecked;
                      setState(() {});
                    },
                    child: text(
                      isReadMoreChecked ? " less" : ' Read More',
                      textColor: MyColorName.primaryDark,
                      fontFamily: fontRegular,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        : text(
            widget.model.description ?? "",
            textColor: MyColorName.colorTextPrimary,
            fontFamily: fontRegular,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          );
  }
}

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  final String url;

  const VideoApp(this.url, {Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColorName.primaryDark,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}