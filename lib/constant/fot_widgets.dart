import 'package:flutter/material.dart';
import 'package:fotapp_flutter/constant/fot_textstyles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FotWidgets {
  //login screen  signIn Text
  static Widget loginSignIn() {
    Widget container = Text("SIGNIN", style: FotTextStyles.signUpStyle);
    return Center(child: container);
  }

  //login screen  signUp Tip Text
  static Widget loginSignUpTip() {
    return Text("Already Registered User? ", style: FotTextStyles.loginSignUpTipStyle);
  }

  //login screen  signUp Text
  static Widget loginSignUp() {
    return Text("SignUp", style: FotTextStyles.loginSignUpStyle);
  }

  //login screen  logo Text
  static Widget logonText() {
    return Text("FOT", style: FotTextStyles.logonTextStyle());
  }

   //login screen  social  login Text
  static Widget socialLoginText() {
    return Text("Social Login",style: FotTextStyles.socialLoginStyle);
  }

    //sizedBox
  static Widget sizedBox(int height) =>
      SizedBox(height: ScreenUtil.getInstance().setHeight(height));
}
