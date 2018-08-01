part of widget_tree_basic;

class Text extends HtmlTag {
  Text({
    dynamic key,
    String id,
    List<String> additionalClasses,
    String text,
  }) : super(
          key: key,
          tag: 'span',
          id: id,
          classes: classesOf('${classPrefix}text', additionalClasses),
          text: text,
        );
}
