import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FotImages {
  //login screen logo icon
  static Image logonIcon() {
    return Image.asset(
      "assets/image/logo.png",
      width: ScreenUtil.getInstance().setWidth(110),
      height: ScreenUtil.getInstance().setHeight(110),
    );
  }

  static Image loginHeader() {
    return Image.asset("assets/image/header.png");
  }

  static Image loginFooter() {
    return Image.asset("assets/image/footer.png");
  }
}