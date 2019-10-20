import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {

  final double height;
  final Color color;
  final String text;

  const MySeparator(
      {this.height = 1, this.color = Colors.grey, this.text = 'Or'});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth() * 4 / 5;
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        List<Widget> children =
            this._buildFlexChild(dashCount, dashWidth, dashHeight);
        return Flex(
          children: children,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }

  List<Widget> _buildFlexChild(int dashCount, double width, double height) {
    List<Widget> children = List.generate(dashCount, (_) {
      bool isHalf = _ == (dashCount / 2);
      return isHalf ? this._buildText() : this._buildDashed(width, height);
    });
    return children;
  }

  // Dashed Text
  Widget _buildText() {
    final style = TextStyle(fontSize: 16.0, fontFamily: "Poppins-Medium");
    return Text(text, style: style);
  }

  // Dashed
  Widget _buildDashed(double width, double height) {
    final BoxDecoration decoration = BoxDecoration(color: color);
    Widget container = DecoratedBox(decoration: decoration);
    return SizedBox(
      width: width,
      height: height,
      child: container,
    );
  }
}
