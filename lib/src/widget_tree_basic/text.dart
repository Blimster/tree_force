part of widget_tree_basic;

class Text extends HtmlTag {
  Text({
    dynamic key,
    String id,
    List<String> additionalClasses,
    String text,
  }) : super(
          key: key,
          id: id,
          tag: 'span',
          classes: classesOf('${classPrefix}text', additionalClasses),
          text: text,
        );
}
