import 'package:flutter/material.dart';

class BackdropPanel extends StatelessWidget {
  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final elevation = 2.0;
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    );

    Widget container = this._buildColumn(theme);
    container = Material(
        elevation: elevation, borderRadius: borderRadius, child: container);
    return container;
  }

  Widget _buildColumn(ThemeData theme) {
    final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch;
    const divider = Divider(height: 1.0);
    final Expanded expanded = Expanded(child: this.child);

    List<Widget> children = [
      this._buildGestureDetector(theme),
      divider,
      expanded
    ];
    Widget container =
        Column(crossAxisAlignment: crossAxisAlignment, children: children);
    return container;
  }

  Widget _buildGestureDetector(ThemeData theme) {
    final HitTestBehavior behavior = HitTestBehavior.opaque;
    Widget container = this._buildGestureContainer(theme);
    container = GestureDetector(
      behavior: behavior,
      onVerticalDragUpdate: this.onVerticalDragUpdate,
      onVerticalDragEnd: this.onVerticalDragEnd,
      onTap: this.onTap,
      child: container,
    );
    return container;
  }

  Widget _buildGestureContainer(ThemeData theme) {
    final double height = 48.0;
    const padding = EdgeInsetsDirectional.only(start: 16.0);
    final AlignmentDirectional alignment = AlignmentDirectional.centerStart;

    Widget container = Tooltip(message: 'Tap to dismiss', child: this.title);
    container =
        DefaultTextStyle(style: theme.textTheme.subhead, child: container);
    container = Container(
        height: height,
        padding: padding,
        alignment: alignment,
        child: container);
    return container;
  }
}
