import 'package:flutter/material.dart';
import 'package:fotapp_flutter/constant/fot_image.dart';
import 'package:fotapp_flutter/page/opt/verification_screen.dart';
import 'package:fotapp_flutter/page/maid_quest_radio.dart';



class LoginScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget clipPath = ClipPath(
      clipper: BottomBezierClipper(),
      child: Container(height: 480, color: Colors.yellow[200], child: null),
    );

    List<Widget> children = [clipPath];
    return Scaffold(
        backgroundColor: Colors.white, body: Column(children: children));
  }
}

class BottomBezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 75);
    Offset controlerPoint = Offset(size.width / 2, size.height);
    Offset endPoint = Offset(size.width, size.height - 75);
    path.quadraticBezierTo(
        controlerPoint.dx, controlerPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height - 75);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomBeziersClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 60);

    Offset controlerPoint = Offset(size.width / 4, size.height);
    Offset endPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(
        controlerPoint.dx, controlerPoint.dy, endPoint.dx, endPoint.dy);

    Offset controlerPoint2 = Offset(size.width / 4 * 3, size.height - 90);
    Offset endPoint2 = Offset(size.width, size.height - 60);

    path.quadraticBezierTo(
        controlerPoint2.dx, controlerPoint2.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AuthenticateScreen extends StatelessWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;
  List _fruits = ["(+65) Singapore", "(+86) China"];
  String _selectedFruit;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
final BuildContext context ;

  AuthenticateScreen(
      {Key key, this.context ,this.primaryColor, this.backgroundColor, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_fruits);
    _selectedFruit = _dropDownMenuItems[0].value;
    Widget container = new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new ClipPath(
            clipper: MyClipper(),
            child: Stack(
              // alignment: const Alignment(0.6, 0.6),
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/image/header.png"),
                  radius: 100.0,
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 58.0, bottom: 100.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "OTP  Verification",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      FotImages.loginHeader(),
                      Text(
                        "Enter your  mobile number",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "We will send you a OTP message",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Center(
              child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 40.0),
            child: DropdownButton(
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins-Medium",
                  fontSize: 12),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              value: _selectedFruit,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
          )),
          new Center(
              child: Container(
            //  alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 40.0),
            // margin: const EdgeInsets.symmetric(horizontal: 60.0),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Medium",
                      fontSize: 18),
                  hintText: "Enter your mobile number",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Medium",
                      fontSize: 18)),
            ),
          )),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    splashColor: Colors.grey,
                    color: Colors.white,
                    child: new Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                        "SEND OTP",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[200]),
                      )),
                    ),
                    onPressed: () => {
                      // Navigator.of(context).pushReplacement(PageRouteBuilder(
                      //     pageBuilder: (_, __, ___) => new VerificationScreen()));

            Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => MaidQuestRadio()),
         )
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // final ThemeData theme = Theme.of(context);
    final elevation = 2.0;
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    );
    //elevation: elevation, borderRadius: borderRadius,
    container = Scaffold(body: container);
    return container;
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = List();
    for (String fruit in fruits) {
      items.add(DropdownMenuItem(value: fruit, child: Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    _selectedFruit = selectedFruit;
  }
}

class MyClipper extends CustomClipper<Path> {
  // @override
  // Path getClip(Size size) {
  //   Path p = new Path();
  //   p.lineTo(size.width, 0.0);
  //   p.lineTo(size.width, size.height * 0.85);
  //   p.arcToPoint(
  //     Offset(0.0, size.height * 0.85),
  //     radius: const Radius.elliptical(50.0, 10.0),
  //     rotation: 0.0,
  //   );
  //   p.lineTo(0.0, 0.0);
  //   p.close();
  //   return p;
  // }

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 75);
    Offset controlerPoint = Offset(size.width / 2, size.height);
    Offset endPoint = Offset(size.width, size.height - 75);
    path.quadraticBezierTo(
        controlerPoint.dx, controlerPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height - 75);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
