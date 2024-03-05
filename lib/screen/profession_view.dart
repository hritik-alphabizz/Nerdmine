import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class ProfessionView extends StatefulWidget {
  const ProfessionView({Key? key}) : super(key: key);

  @override
  State<ProfessionView> createState() => _ProfessionViewState();
}

class _ProfessionViewState extends State<ProfessionView> {
  Map<String, bool> values = {
    'Medical Profession': false,
    'Engineering Profession': false,
    'Defence Profession': false,
    'Education Profession': false,
    'Management Profession': false,
    'Medical Profession': false,
    'Engineering Profession': false,
    'Defence Profession': false,
    'Education Profession': false,
    'Management Profession': false,
    'Medical Profession': false,
    'Engineering Profession': false,
    'Defence Profession': false,
    'Education Profession': false,
    'Management Profession': false,
    'Medical Profession': false,
    'Engineering Profession': false,
    'Defence Profession': false,
    'Education Profession': false,
    'Management Profession': false,
  };
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
          title: text('Choice of profession',
              textColor: MyColorName.primaryDark,
              fontFamily: fontMedium,
              fontSize: 14.sp)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
         SizedBox(height: 20,),
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
                hintText: "Search Profession",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(48.sp),
                  borderSide: BorderSide(
                      color: MyColorName.colorTextSecondary.withOpacity(0.2)),
                ),
              ),
            ),
            Container(
              height: 60.h,
              child: ListView(
                children: values.keys.map((String key) {
                  return Row(
                    children: [
                      Checkbox(
                          value: values[key],
                          onChanged: (value) {
                            setState(() {
                              values[key] = value!;
                            });
                          }),
                      Text('$key')
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
