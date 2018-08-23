part of widget_tree_basic;

class Text extends HtmlTag {
  Text({
    dynamic key,
    String id,
    String text,
    List<String> classes,
  }) : super(
          key: key,
          tag: 'span',
          id: id,
          classes: classesOf('${classPrefix}text', classes),
          text: text,
        );
}
