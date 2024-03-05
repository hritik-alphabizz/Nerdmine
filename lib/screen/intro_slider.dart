
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nerdmine/generated/assets.dart';
import 'package:nerdmine/model/common_model.dart';
import 'package:nerdmine/screen/login_screen.dart';
import 'package:nerdmine/utils/colors.dart';
import 'package:nerdmine/utils/constant.dart';
import 'package:nerdmine/utils/widget.dart';
import 'package:sizer/sizer.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  List<BannerModel> bannerList = [
    BannerModel(
        "Connect with the people\nwho can help",
        "Connect with people who can help you make right career decisions, achieve your goals and make right choice towards your future.",
        Assets.imagesBanner0,
        Assets.imagesButton0),
    BannerModel("Learn the skill you need\nto succeed", "Skills for success can be learned through education, training, and workshops.",
        Assets.imagesBanner1, Assets.imagesButton1),
    BannerModel("Find the right job that you like", "NerdMine platform can help you find and land your dream job.", Assets.imagesBanner2,
        Assets.imagesButton1),
  ];
  int currentIndex = 0;
  CarouselController controller = new CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: getHeight(1280),
            width: getWidth(720),
            decoration: BoxDecoration(
                color: MyColorName.colorBg2
            ),
            padding: EdgeInsets.symmetric(horizontal: getWidth(47)),
            child: Column(
              children: [
                  boxHeight(39),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      currentIndex!=2?InkWell(
                        onTap: (){
                          navigateScreen(context, LoginScreen());
                        },
                        child: text(
                          "Skip",
                          textColor: MyColorName.colorTextPrimary,
                          under: true,
                          fontFamily: fontMedium,
                          fontSize: 20.sp,
                        ),
                      ):boxHeight(49),
                    ],
                  ),
                CarouselSlider(items: bannerList.map((e){

                    return Container(
                      child: Column(
                        children: [
                            boxHeight(70),
                            Container(
                              height: 180.0,
                              child: Image.asset(e.image, width: getWidth(625)),
                            ),
                            boxHeight(86),
                            text(e.title,
                                textColor: MyColorName.colorTextThird, fontFamily: fontBold, isLongText: true, isCentered: true, fontSize: 20.sp),
                            boxHeight(30),
                            Container(
                              width: getWidth(625),
                              child: text(e.des,
                                  textColor: MyColorName.colorTextSecondary,
                                  fontFamily: fontRegular,
                                  isCentered: true,
                                  isLongText: true,
                                  fontSize: 10.sp),
                            ),
                            boxHeight(39),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: bannerList.map((e) {
                                int i = bannerList.indexWhere((element) => element.image==e.image);
                              return Container(
                                    width: currentIndex==i?getWidth(40):getWidth(20),
                                height: getHeight(8),
                                  margin: EdgeInsets.only(right: getWidth(10)),
                                  decoration: boxDecoration(
                                      radius: 5.sp, bgColor: currentIndex == i ? MyColorName.primaryLite : MyColorName.colorTextSecondary),
                                );
                              }).toList(),
                            ),
                            boxHeight(60),
                            InkWell(
                              onTap: () {
                                if (currentIndex == 2) {
                                  navigateScreen(context, LoginScreen());
                                  return;
                                }
                                controller.nextPage();
                              },
                              child: Container(
                                  child: Image.asset(
                                e.button,
                                height: getWidth(134),
                                width: getWidth(134),
                                fit: BoxFit.fill,
                              )),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    carouselController: controller,
                    options: CarouselOptions(
                        height: getHeight(1050),
                        viewportFraction: 1.0,
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
