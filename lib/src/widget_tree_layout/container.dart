part of widget_tree_layout;

class Container extends HtmlTag {
  Container({
    dynamic key,
    List<String> classes,
    List<Widget> children,
  }) : super(
          key: key,
          tag: 'div',
          classes: classesOf('wt-container', classes),
          children: children,
        );
}
