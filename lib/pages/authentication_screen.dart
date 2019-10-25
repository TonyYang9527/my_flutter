import 'package:flutter/material.dart';
import 'package:my_flutter/constant/fot_image.dart';

class AuthenticateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget clipPath = ClipPath(
      clipper: BottomBezierClipper(),
      child: Container(
          color: Colors.deepOrangeAccent[100], height: 480, child: null),
    );

    Widget arc = Arc(
      height: 50,
      clipShadows: [ClipShadow(color: Colors.white)],
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/image/header.png',
            fit: BoxFit.fill,
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 32.0,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 30.0,
              color: Colors.yellowAccent[50],
              child: Center(
                child: Text(
                  'JAMES DEAN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.pink, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          )
        ],
      ),
    );

    Padding padding = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Synopsis',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 16.0),
          Text('James Dean was born on February 8, 1931, in Marion, Indiana. '
              'He starred in the film adaptation of the John Steinbeck novel '
              'East of Eden, for which he received a posthumous Oscar '
              'nomination. Dean\'s next starring role as an emotionally '
              'tortured teen in Rebel Without a Cause made him into the '
              'embodiment his generation. In early autumn 1955, Dean was killed '
              'in a car crash, quickly becoming an enduring film icon whose '
              'legacy has endured for decades. His final film Giant, was also '
              'released posthumously.'),
        ],
      ),
    );

    List<Widget> children = [arc, padding];
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: children,
      ),
    );
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

class Arc extends StatelessWidget {
  const Arc(
      {Key key,
      @required this.height,
      @required this.child,
      this.edge = Edge.BOTTOM,
      this.arcType = ArcType.CONVEX,
      this.clipShadows = const []})
      : super(key: key);

  /// The widget which one of [edge]s is going to be clippddddded as arc
  final Widget child;

  ///The height of the arc
  final double height;

  ///The edge of the widget which clipped as arc
  final Edge edge;

  ///The type of arc which can be [ArcType.CONVEX] or [ArcType.CONVEY]
  final ArcType arcType;

  ///List of shadows to be cast on the border
  final List<ClipShadow> clipShadows;

  @override
  Widget build(BuildContext context) {
    var clipper = ArcClipper(height, edge, arcType);
    return CustomPaint(
      painter: ClipShadowPainter(clipper, clipShadows),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}

enum ArcType { CONVEY, CONVEX }
enum Edge { TOP, RIGHT, BOTTOM, LEFT }

class ArcClipper extends CustomClipper<Path> {
  ArcClipper(this.height, this.edge, this.arcType);
  final double height;
  final Edge edge;
  final ArcType arcType;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.TOP:
        return _getTopPath(size);
      case Edge.RIGHT:
        return _getRightPath(size);
      case Edge.BOTTOM:
        return _getBottomPath(size);
      case Edge.LEFT:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    if (arcType == ArcType.CONVEX) {
      path.lineTo(0.0, size.height - height);
      //Adds a quadratic bezier segment that curves from the current point
      //to the given point (x2,y2), using the control point (x1,y1).
      path.quadraticBezierTo(
          size.width / 4, size.height, size.width / 2, size.height);
      path.quadraticBezierTo(
          size.width * 3 / 4, size.height, size.width, size.height - height);

      path.lineTo(size.width, 0.0);
    } else {
      path.moveTo(0.0, size.height);
      path.quadraticBezierTo(size.width / 4, size.height - height,
          size.width / 2, size.height - height);
      path.quadraticBezierTo(
          size.width * 3 / 4, size.height - height, size.width, size.height);
      path.lineTo(size.width, 0.0);
      path.lineTo(0.0, 0.0);
    }
    path.close();

    return path;
  }

  Path _getTopPath(Size size) {
    var path = Path();
    if (arcType == ArcType.CONVEX) {
      path.moveTo(0.0, height);

      path.quadraticBezierTo(size.width / 4, 0.0, size.width / 2, 0.0);
      path.quadraticBezierTo(size.width * 3 / 4, 0.0, size.width, height);

      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
    } else {
      path.quadraticBezierTo(size.width / 4, height, size.width / 2, height);
      path.quadraticBezierTo(size.width * 3 / 4, height, size.width, 0.0);
      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
    }
    path.close();

    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    if (arcType == ArcType.CONVEX) {
      path.moveTo(height, 0.0);

      path.quadraticBezierTo(0.0, size.height / 4, 0.0, size.height / 2);
      path.quadraticBezierTo(0.0, size.height * 3 / 4, height, size.height);

      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0.0);
    } else {
      path.quadraticBezierTo(height, size.height / 4, height, size.height / 2);
      path.quadraticBezierTo(height, size.height * 3 / 4, 0.0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0.0);
    }
    path.close();

    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    if (arcType == ArcType.CONVEX) {
      path.moveTo(size.width - height, 0.0);

      path.quadraticBezierTo(
          size.width, size.height / 4, size.width, size.height / 2);
      path.quadraticBezierTo(
          size.width, size.height * 3 / 4, size.width - height, size.height);

      path.lineTo(0.0, size.height);
      path.lineTo(0.0, 0.0);
    } else {
      path.moveTo(size.width, 0.0);
      path.quadraticBezierTo(size.width - height, size.height / 4,
          size.width - height, size.height / 2);
      path.quadraticBezierTo(
          size.width - height, size.height * 3 / 4, size.width, size.height);
      path.lineTo(0.0, size.height);
      path.lineTo(0.0, 0.0);
    }
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    ArcClipper oldie = oldClipper as ArcClipper;
    return height != oldie.height ||
        arcType != oldie.arcType ||
        edge != oldie.edge;
  }
}

class ClipShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final List<ClipShadow> clipShadows;

  ClipShadowPainter(this.clipper, this.clipShadows);

  @override
  void paint(Canvas canvas, Size size) {
    clipShadows.forEach((ClipShadow shadow) {
      canvas.drawShadow(
          clipper.getClip(size), shadow.color, shadow.elevation, true);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ClipShadow {
  final Color color;
  final double elevation;

  ClipShadow({@required this.color, this.elevation = 1});
}
