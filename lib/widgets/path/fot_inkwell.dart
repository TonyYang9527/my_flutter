import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FotInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const FotInkWell({Key key,  @required this.child,@required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: this._buildInkWellChild());
  }

  Widget _buildInkWellChild() {
    Widget container = Container(
        height: this._setHeight(100),
        decoration: this._buildBoxDecoration(),
        child: this._buildInkWellContent());
    return container;
  }

  Widget _buildInkWellContent() {
    final Color color = Colors.transparent;
    Widget container = Center(child: child);
    container = InkWell(onTap: onTap, child: container);
    container = Material(color: color, child: container);
    return container;
  }

  BoxDecoration _buildBoxDecoration() {
    final BorderRadius borderRadius = BorderRadius.circular(6.0);
    final LinearGradient gradient = LinearGradient(
        colors: [Color(0xFF17ead9), Color(0xFF6078ea), Color(0xFF17ead9)]);
    final BoxShadow boxShadow = BoxShadow(
        color: Color(0xFF6078ea).withOpacity(.3),
        offset: Offset(0.0, 8.0),
        blurRadius: 8.0);

    BoxDecoration container = BoxDecoration(
        gradient: gradient, borderRadius: borderRadius, boxShadow: [boxShadow]);
    return container;
  }

  double _setHeight(int height) => ScreenUtil.getInstance().setHeight(height);
}
