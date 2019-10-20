import 'package:flutter/material.dart';

class BackdropTitle extends AnimatedWidget {
  
  const BackdropTitle({Key key, Listenable listenable})
      : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final TextStyle style = Theme.of(context).primaryTextTheme.title;
    final TextOverflow overflow = TextOverflow.ellipsis;

    Widget container = this._buildStack(animation);
    container = DefaultTextStyle(
        style: style, softWrap: false, overflow: overflow, child: container);
    return container;
  }

  Widget _buildStack(Animation<double> animation) {
    final ReverseAnimation filterAnimation = ReverseAnimation(animation);
    final Widget filterTitle = Text('Select a Filter');
    final Widget resultTitle =
        Text('Match Result', textAlign: TextAlign.center);

    List<Widget> children = [
      this._buildOpacity(filterAnimation, filterTitle),
      this._buildOpacity(animation, resultTitle)
    ];
    Widget container = Stack(children: children);
    return container;
  }

  Widget _buildOpacity(Animation<double> animation, Widget child) {
    final double opacity = this._buildCurvedAnimation(animation);
    Widget container = Opacity(opacity: opacity, child: child);
    return container;
  }

  double _buildCurvedAnimation(Animation<double> animation) {
    const curve = Interval(0.5, 1.0);
    return CurvedAnimation(parent: animation, curve: curve).value;
  }
}
