import 'package:flutter/material.dart';
import 'package:fotapp_flutter/constant/fot_image.dart';



class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget container = Container(child: FotImages.logonIcon());
    return Material(child: container);
  }
}
