import 'package:flutter/material.dart';


class Category {
  const Category({this.title, this.assets});
  final String title;
  final List<String> assets;

  @override
  String toString() => '$runtimeType("$title")';
}


class CategoryView extends StatelessWidget {
  const CategoryView({Key key, this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EdgeInsets padding =
        EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0);
    final Key key = PageStorageKey<Category>(category);
    //build  Category Assets
    List<Widget> children = this._buildCategoryAssets(category, theme);
    Widget container = ListView(key: key, padding: padding, children: children);
    container = Scrollbar(child: container);
    return container;
  }

  // build  Category Assets
  List<Widget> _buildCategoryAssets(Category category, ThemeData theme) {
    List<Widget> _categoryAssets = category.assets.map<Widget>((String asset) {
      return _buildCategoryColumn(asset, theme);
    }).toList();
    return _categoryAssets;
  }

  // build  Category Column
  Widget _buildCategoryColumn(String name, ThemeData theme) {
    final Widget sizedBox = new SizedBox(height: 24.0);
    final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch;

    List<Widget> children = [
      _buildCard(name, theme),
      sizedBox,
    ];
    Widget container =
        Column(crossAxisAlignment: crossAxisAlignment, children: children);
    return container;
  }

  // build  Category Card
  Widget _buildCard(String name, ThemeData theme) {
    final double width = 144.0;
    final Alignment alignment = Alignment.center;

    Widget container = this._buildColumnWidget(name, theme);
    container = Container(width: width, alignment: alignment, child: container);
    container = Card(child: container);
    return container;
  }

  // build  Column
  Widget _buildColumnWidget(String name, ThemeData theme) {
    List<Widget> children = [
      this._buildImage(name),
      this._buildContainer(name, theme)
    ];
    Widget container = Column(children: children);
    return container;
  }

  // build  Image
  Widget _buildImage(String name) {
    return Image.asset(
      name,
      package: 'flutter_gallery_assets',
      fit: BoxFit.contain,
    );
  }

  // build  Text
  Widget _buildContainer(String name, ThemeData theme) {
    final EdgeInsets padding = EdgeInsets.only(bottom: 16.0);
    final AlignmentDirectional alignment = AlignmentDirectional.center;

    Widget container = Text(
      name,
      style: theme.textTheme.caption,
    );
    container =
        Container(padding: padding, alignment: alignment, child: container);
    return container;
  }
}