import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/ui/screen/cart_screen.dart';

displayToast(context,
    {String? title, String? desc, int? seconds, String type = 'error'}) async {
  Flushbar(
    backgroundColor: const Color(0xff2a2626),
    margin: const EdgeInsets.all(8).copyWith(bottom: 16),
    borderRadius: BorderRadius.circular(8),
    icon: Icon(
      type == 'success' ? Icons.info_outline : Icons.error_outline,
      size: 28.0,
      color:
          type == 'success' ? ThemeColors.statusColor : ThemeColors.errorColor,
    ),
    title: title ?? 'Title',
    message: desc ?? 'Message',
    duration: const Duration(seconds: 4),
    leftBarIndicatorColor:
        type == 'success' ? ThemeColors.statusColor : ThemeColors.errorColor,
  ).show(context);
}

loadingDialog(BuildContext context, {String? asset}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          height: ScreenUtil().setHeight(300),
          alignment: Alignment.center,
          child: asset == null
              ? const CircularProgressIndicator()
              : Lottie.asset(
                  asset,
                  height: 200,
                  width: 200,
                ),
        ),
      );
    },
  );
}

