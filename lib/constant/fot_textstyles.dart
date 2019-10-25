import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter/constant/fot_fontFamily.dart';

class FotTextStyles {
  static const TextStyle signUpStyle = TextStyle(
      color: Colors.white,
      fontFamily: FotFontFamily.poppinsBold,
      fontSize: 18,
      letterSpacing: 1.0);

  static const TextStyle loginSignUpTipStyle =
      TextStyle(fontFamily: FotFontFamily.poppinsMedium);

  static const TextStyle loginSignUpStyle = TextStyle(
      color: Color(0xFF5d74e3), fontFamily: FotFontFamily.poppinsBold);

  static TextStyle logonTextStyle() {
    return TextStyle(
        fontFamily: FotFontFamily.poppinsBold,
        fontSize: ScreenUtil.getInstance().setSp(46),
        letterSpacing: .6,
        fontWeight: FontWeight.bold);
  }

  static const TextStyle socialLoginStyle =
      TextStyle(fontSize: 16.0, fontFamily: FotFontFamily.poppinsMedium);
}
