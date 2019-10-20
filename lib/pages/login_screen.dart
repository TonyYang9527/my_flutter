import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fotapp_flutter/widgets/form/login_form.dart';
import 'package:fotapp_flutter/widgets/icon/social_icon.dart';
import 'package:fotapp_flutter/constant/fot_icons.dart';
import 'package:fotapp_flutter/constant/fot_widgets.dart';
import 'package:fotapp_flutter/widgets/path/fot_inkwell.dart';
import 'package:fotapp_flutter/constant/fot_images.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    List<Widget> children = [
      this._buildHeaderFooter(),
      this._buildLoginWidget()
    ];
    Widget container = Stack(fit: StackFit.expand, children: children);
    container = Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: container);
    return container;
  }

  Widget _buildHeaderFooter() {
    Expanded expanded = Expanded(child: Container());
    List<Widget> children = [this._header(), expanded, FotImages.loginFooter()];
    Widget container = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children,
    );
    return container;
  }

  Widget _buildLoginWidget() {
    final EdgeInsets padding =
        EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0);

    List<Widget> children = [
      this._buildLogo(),
      FotWidgets.sizedBox(180),
      this._buildLoginForm(),
      FotWidgets.sizedBox(40),
      this._buildSignIn(),
      FotWidgets.sizedBox(40),
      this._buildSeparator(),
      FotWidgets.sizedBox(40),
      this._buildSocial(),
      FotWidgets.sizedBox(30),
      this._buildSignUp(),
    ];
    Widget container = Column(children: children);
    container = Padding(padding: padding, child: container);
    container = SingleChildScrollView(child: container);
    return container;
  }

  Widget _buildLogo() {
    List<Widget> children = [
      FotImages.logonIcon(),
      FotWidgets.logonText(),
    ];
    return Row(children: children);
  }

  Widget _buildLoginForm() {
    return FormCard();
  }

  Widget _buildSignIn() {
    return FotInkWell(child: FotWidgets.loginSignIn(), onTap: () {});
  }

  Widget _buildSeparator() {
    List<Widget> children = [
      horizontalLine(),
      FotWidgets.socialLoginText(),
      horizontalLine()
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildSocial() {
    SocialIcon facebook = CustomIcons.facebookSocialIcon(() {});
    SocialIcon google = CustomIcons.googleSocialIcon(() {});
    List<Widget> children = [facebook, google];
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  Widget _buildSignUp() {
    Widget container = FotWidgets.loginSignUp();
    container = InkWell(onTap: () {}, child: container);
    List<Widget> children = [FotWidgets.loginSignUpTip(), container];
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  Widget horizontalLine() => Container(
        width: ScreenUtil.getInstance().setWidth(200),
        height: 1.0,
        color: Colors.black26.withOpacity(.2),
      );

  // header
  Widget _header() => Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: FotImages.loginHeader(),
      );
}
