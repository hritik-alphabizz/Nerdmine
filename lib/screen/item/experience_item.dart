import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';
import '../../model/user_info2.dart';
import '../../res/AppColors.dart';
import '../../utils/constant.dart';
import '../../utils/widget.dart';
class ExperienceItem extends StatelessWidget {
  ExperienceInfo _data;
   ExperienceItem(this._data,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Image.asset(Assets.imagesChair),
          boxWidth(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                text('${_data.companyName}  ', textColor: AppColors.black, fontFamily: fontBold, fontSize: 12.sp),
                boxHeight(10),
                text('Ui/UX Designer at Microsoft Corporation  ',
                    textColor: AppColors.black, fontFamily: fontBold, fontSize: 10.sp),
                boxHeight(5),
                Row(
                  children: [
                    text('Feb 2021- Present  ',
                        textColor: Color(0xFFB7B7B7), fontFamily: fontRegular, fontSize: 12.sp),
                    text(' | 1 year 5 mos  ',
                        textColor: AppColors.black, fontFamily: fontRegular, fontSize: 12.sp),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
