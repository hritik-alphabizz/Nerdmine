import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({Key? key}) : super(key: key);

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
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
          title: text('Certification',
              textColor: MyColorName.primaryDark,
              fontFamily: fontMedium,
              fontSize: 14.sp)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              boxHeight(44),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(
                        color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                  ),
                  fillColor: MyColorName.colorBg1,
                  filled: true,
                  counterText: '',
                  contentPadding: EdgeInsets.all(getWidth(30)),
                  hintText: "Certification Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(48.sp),
                    borderSide: BorderSide(
                        color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                  ),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Colors.blue,
                      )),
                  Text(
                    "Add More",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),   boxHeight(99.h),
              Container(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999))),
                    onPressed: () {
                      Navigator.pop(context);
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
      ),
    );
  }
}
