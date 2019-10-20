import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:fotapp_flutter/survey/category.dart';
import 'package:fotapp_flutter/survey/backdrop_title.dart';
import 'package:fotapp_flutter/survey/backdrop_panel.dart';
import 'package:fotapp_flutter/survey/mock.dart';
import 'package:fotapp_flutter/utils/fotapp_utils.dart';

class Backdrop extends StatefulWidget {
  static const String routeName = '/material/backdrop';
  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Category _category = allCategories[0];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget icon = AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        semanticLabel: 'close',
        progress: _controller.view);
    final Widget button =
        IconButton(onPressed: _toggleBackdropPanelVisibility, icon: icon);
    List<Widget> actions = [button];
    final Widget title = BackdropTitle(listenable: _controller.view);

    Widget container = AppBar(elevation: 0.0, title: title, actions: actions);
    final Widget body = LayoutBuilder(builder: _buildStack);
    container = Scaffold(appBar: container, body: body);
    return container;
  }

  void _changeCategory(Category category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  // By design: the panel can only be opened with a swipe. To close the panel
  // the user must either tap its heading or the backdrop's menu icon.
  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    _controller.value -=
        details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  // Stacks a BackdropPanel, which displays the selected category, on top
  // of the backdrop. The categories are displayed with ListTiles. Just one
  // can be selected at a time. This is a LayoutWidgetBuild function because
  // we need to know how big the BackdropPanel will be to set up its
  // animation.
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    final Color primary = theme.primaryColor;
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;
    final double top = panelTop - MediaQuery.of(context).padding.bottom;
    final double bottom = panelTop - panelSize.height;

    final Animation<RelativeRect> panelAnimation =
        _controller.drive(this._buildPanelAnimation(top, bottom));
    List<Widget> backdropItems = this._buildBackdropItems(allCategories);
    List<Widget> children = [
      this._buildListTileTheme(theme, backdropItems),
      this._buildPositionedTransition(panelAnimation)
    ];

    Widget container = Stack(children: children);
    container = Container(key: _backdropKey, color: primary, child: container);
    return container;
  }

  // build  Backdrop Items
  List<Widget> _buildBackdropItems(List<Category> categories) {
    List<Widget> _backdropItems = categories.map<Widget>((Category category) {
      final bool selected = category == this._category;
      return this._buildMaterial(selected, category);
    }).toList();
    return _backdropItems;
  }

  // build Material
  Widget _buildMaterial(bool selected, Category category) {
    const borderRadius = BorderRadius.all(Radius.circular(4.0));
    const shape = RoundedRectangleBorder(
      borderRadius: borderRadius,
    );
    Color color = this._selectedColor(selected);
    Widget container = Text(category.title);
    container = ListTile(
        title: container,
        selected: selected,
        onTap: () {
          _changeCategory(category);
        });

    container = Material(shape: shape, color: color, child: container);
    return container;
  }

  Color _selectedColor(bool selected) {
    return selected ? Colors.white.withOpacity(0.25) : Colors.transparent;
  }

  RelativeRectTween _buildPanelAnimation(double top, double bottom) {
    final RelativeRect begin =
        AnimationUtils.relativeRect(0.0, top, 0.0, bottom);
    final RelativeRect end = AnimationUtils.relativeRect(0.0, 0.0, 0.0, 0.0);
    return AnimationUtils.relativeRectTween(begin, end);
  }

  Widget _buildListTileTheme(ThemeData theme, List<Widget> backdropItems) {
    final crossAxisAlignment = CrossAxisAlignment.stretch;
    const padding = EdgeInsets.symmetric(horizontal: 16.0);

    Color iconColor = theme.primaryIconTheme.color;
    Color textColor = theme.primaryTextTheme.title.color.withOpacity(0.6);
    Color selectedColor = theme.primaryTextTheme.title.color;

    Widget container =
        Column(crossAxisAlignment: crossAxisAlignment, children: backdropItems);
    container = Padding(padding: padding, child: container);
    container = ListTileTheme(
        iconColor: iconColor,
        textColor: textColor,
        selectedColor: selectedColor,
        child: container);
    return container;
  }

  // build Material
  Widget _buildPositionedTransition(Animation<RelativeRect> panelAnimation) {
    Widget title = Text(_category.title);
    Widget container = CategoryView(category: _category);
    container = BackdropPanel(
        onTap: _toggleBackdropPanelVisibility,
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        title: title,
        child: container);
    container = PositionedTransition(rect: panelAnimation, child: container);

    return container;
  }
}
