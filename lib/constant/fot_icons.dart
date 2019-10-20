import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/icon/social_icon.dart';
import 'package:fotapp_flutter/constant/fot_colors.dart';
import 'package:fotapp_flutter/constant/fot_fontFamily.dart';

class CustomIcons {
  static const IconData _facebook =
      IconData(0xe901, fontFamily: FotFontFamily.customIcons);
  static const IconData _googlePlus =
      IconData(0xe902, fontFamily: FotFontFamily.customIcons);

  //facebook Social Icon
  static SocialIcon facebookSocialIcon(Function onPressed) {
    return SocialIcon(
      colors: FotColors.facebook,
      iconData: CustomIcons._facebook,
      onPressed: onPressed != null ? onPressed : () {},
    );
  }

  //google Social Icon
  static SocialIcon googleSocialIcon(Function onPressed) {
    return SocialIcon(
      colors: FotColors.google,
      iconData: CustomIcons._googlePlus,
      onPressed: onPressed != null ? onPressed : () {},
    );
  }
}


