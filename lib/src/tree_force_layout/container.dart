part of tree_force_layout;

class Container extends HtmlTag {
  Container({
    dynamic key,
    String id,
    List<String> classes,
    List<Widget> children,
  }) : super(
          key: key,
          id: id,
          tag: 'div',
          classes: classesOf('${classPrefix}container', classes),
          children: children,
        );
}
