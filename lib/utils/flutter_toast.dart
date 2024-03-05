import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nerdmine/res/Fonts.dart';

import '../res/AppColors.dart';

abstract class FlutterToastX {
  static void showErrorToast(BuildContext context, String text) async {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.colorPrimary),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_rounded, color: AppColors.white),
          const SizedBox(width: 6.0),
          Expanded(child: Text("$text", style: textStyleWhite12px600w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static void showErrorToastCenter(BuildContext context, String text) async {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.red),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_rounded, color: AppColors.white),
          const SizedBox(width: 6.0),
          Expanded(child: Text("$text", style: textStyleWhite14px500w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static void showErrorToastTop(BuildContext context, String text) async {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.red),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_rounded, color: AppColors.white),
          const SizedBox(width: 6.0),
          Expanded(child: Text("$text", style: textStyleWhite14px500w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static void showErrorToastBottom(BuildContext context, String text) async {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: AppColors.red),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_rounded, color: AppColors.white),
          const SizedBox(width: 6.0),
          Expanded(child: Text("$text", style: textStyleWhite14px500w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }

  static void showSuccessToastBottom(BuildContext context, String text, {int duration = 4}) async {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Colors.green[900]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: AppColors.white),
          const SizedBox(width: 6.0),
          Expanded(child: Text("$text", style: textStyleWhite12px600w, maxLines: 2, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }

  static void showToastCenter(String text) async {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  static void showToastB(String text) async {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        fontSize: 16.0);
  }
}
